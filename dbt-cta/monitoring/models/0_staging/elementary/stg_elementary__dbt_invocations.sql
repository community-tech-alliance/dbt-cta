with
    source as (select * from {{ source("elementary", "dbt_invocations") }}),
    cast_datatypes as (
        select
            cast(invocation_id as string) as invocation_id,
            cast(job_id as string) as job_id,
            cast(job_name as string) as job_name,
            cast(job_run_id as string) as job_run_id,
            cast(run_started_at as timestamp) as run_started_at,
            cast(run_completed_at as timestamp) as run_completed_at,
            cast(generated_at as timestamp) as generated_at,
            cast(command as string) as command,
            cast(dbt_version as string) as dbt_version,
            cast(elementary_version as string) as elementary_version,
            cast(full_refresh as string) as full_refresh,
            cast(invocation_vars as string) as invocation_vars,
            cast(vars as string) as vars,
            cast(target_name as string) as target_name,
            cast(target_database as string) as target_database,
            cast(target_schema as string) as target_schema,
            cast(target_profile_name as string) as target_profile_name,
            cast(threads as integer) as threads,
            cast(selected as string) as selected,
            cast(yaml_selector as string) as yaml_selector,
            cast(project_id as string) as project_id,
            cast(project_name as string) as project_name,
            cast(env as string) as env,
            cast(env_id as string) as env_id,
            cast(cause_category as string) as cause_category,
            cast(cause as string) as cause,
            cast(pull_request_id as string) as pull_request_id,
            cast(git_sha as string) as git_sha,
            cast(orchestrator as string) as orchestrator,
            cast(dbt_user as string) as dbt_user
        from source
    ),
    extract_vars as (
        select
            * except(selected),
            json_extract_scalar(vars, "$.sync_name") as sync_name,
            json_extract_scalar(vars, "$.partner_name") as partner_name,
            json_extract_scalar(vars, "$.airflow_run_id") as airflow_run_id,
            -- remove quotes, brackets, and replace other non-alphanumeric characters with underscores
            regexp_replace(regexp_replace(selected, '["\\[\\]]', ''), '[^a-zA-Z0-9]+', '_') as selected
        from cast_datatypes
    ),
    convert_timezones as (
        select
            *,
            {{ dbt_date.convert_timezone("run_started_at", 'America/New_York', 'UTC') }} as run_started_at_et,
            {{ dbt_date.convert_timezone("run_completed_at", 'America/New_York', 'UTC') }} as run_completed_at_et,
            {{ dbt_date.convert_timezone("generated_at", 'America/New_York', 'UTC') }} as generated_at_et
        from extract_vars
    ),
    add_invocation_type as (
        select *
        ,  target_name || '_' || command || '_' || selected as invocation_type
        from convert_timezones
    ),
    classify_invocation_type as (
        select * except(invocation_type)
        , case
            when invocation_type = 'cta_test__0_ctes_source_cta' then '0 - Test CTA Sources'
            when invocation_type = 'cta_run_tag_cta' then '1 - Build CTA Models'
            when invocation_type = 'cta_test_tag_cta' then '2 - Test CTA Models'
            when invocation_type = 'partner_test__2_partner_matviews_source_cta' then '3 - Test Partner Sources'
            when invocation_type = 'partner_run_tag_partner' then '4 - Build Partner Models'
            when invocation_type = 'partner_test_tag_partner' then '5 - Test Partner Models'
            else invocation_type end as invocation_type
        from add_invocation_type
    ),
    final as (
        select
            invocation_id,
            job_id,
            job_name,
            job_run_id,
            run_started_at_et as run_started_at,
            run_completed_at_et as run_completed_at,
            generated_at_et as generated_at,
            command,
            dbt_version,
            elementary_version,
            full_refresh,
            invocation_vars,
            vars,
            target_name,
            target_database,
            target_schema,
            target_profile_name,
            threads,
            selected,
            invocation_type,
            yaml_selector,
            project_id,
            project_name,
            env,
            env_id,
            cause_category,
            cause,
            pull_request_id,
            git_sha,
            orchestrator,
            dbt_user,
            sync_name,
            partner_name,
            airflow_run_id
        from classify_invocation_type
    )

select *
from final
