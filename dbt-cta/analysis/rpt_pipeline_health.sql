/*
This view is used to generate the pipeline health dashboard. It is a view on top of
automatically generated tables in the `elementary` schema.
*/

create or replace view elementary.rpt_pipeline_health as
(
with base as (select *
              from elementary.dbt_invocations inv


              where vars != '{}')

   , extract_vars as (select invocation_id
                           , command
                           , run_started_at
                           , run_completed_at
                           , target_name
                           , selected
                           , json_extract_scalar(vars, "$.sync_name")      as sync_name
                           , json_extract_scalar(vars, "$.partner_name")   as partner_name
                           , json_extract_scalar(vars, "$.airflow_run_id") as airflow_run_id
                      from base)

   , run_results as (select invocation_id, resource_type, status, failures, rows_affected
                     from elementary.dbt_run_results)

   , base_joined as (select ev.*
                          , rr.* except (invocation_id)
                     from extract_vars ev
                              left join run_results rr using (invocation_id)
                     where sync_name is not null

                     order by run_started_at)

   , group_by_invocation as (select invocation_id
                                  , cast(run_started_at as timestamp) as run_started_at
                                  , cast(run_completed_at as timestamp) as run_completed_at
                                  , command
                                  , target_name
                                  , selected
                                  , sync_name
                                  , partner_name
                                  , airflow_run_id
                                  , resource_type
                                  , status
                                  , count(*) as count
                             from base_joined
                             group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
                             order by airflow_run_id, run_started_at)


   , group_by_run as (select sync_name
                           , partner_name
                           , airflow_run_id
                           , count(distinct invocation_id)                         as num_steps
                           ,min(run_started_at)                                   as run_started_at
                           ,max(run_completed_at)                                   as run_completed_at
                           , coalesce(sum(case
                                     when resource_type = 'test' and status not in ('pass', 'warn')
                                         then count end)    ,0)                       as test_errors
                           , coalesce(sum(case
                                     when resource_type = 'model' and status not in ('success')
                                         then count end)    ,0)                       as model_errors
                           , coalesce(sum(case when resource_type = 'test' then count end),0)  as total_tests
                           , coalesce(sum(case when resource_type = 'model' then count end),0) as total_models
                      from group_by_invocation
                      group by 1, 2, 3)

select *
     , case when coalesce(test_errors, 0) + coalesce(model_errors, 0) > 0 then false else true end as success

     , case when coalesce(test_errors, 0) + coalesce(model_errors, 0) > 0 then 0 else 1 end as success_int
, RANK() over (partition by sync_name, partner_name, extract(date from run_started_at) order by run_started_at desc) as most_recent_run_per_day
, total_models - model_errors as successful_models
, total_tests - test_errors as successful_tests
, datetime_diff(run_completed_at, run_started_at, MINUTE) as runtime
from group_by_run
order by 1, 2, 3
    );
