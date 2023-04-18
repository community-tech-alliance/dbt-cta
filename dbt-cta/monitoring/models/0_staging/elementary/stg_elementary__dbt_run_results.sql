with
    source as (select * from {{ source("elementary", "dbt_run_results") }}),
    cast_datatypes as (
        select
            cast(model_execution_id as string) as model_execution_id,
            cast(unique_id as string) as unique_id,
            cast(invocation_id as string) as invocation_id,
            cast(generated_at as timestamp) as generated_at,
            cast(name as string) as name,
            cast(message as string) as message,
            cast(status as string) as status,
            cast(resource_type as string) as resource_type,
            cast(execution_time as float64) as execution_time,
            cast(execute_started_at as timestamp) as execute_started_at,
            cast(execute_completed_at as timestamp) as execute_completed_at,
            cast(compile_started_at as timestamp) as compile_started_at,
            cast(compile_completed_at as timestamp) as compile_completed_at,
            cast(rows_affected as int) as rows_affected,
            cast(full_refresh as boolean) as full_refresh,
            cast(compiled_code as string) as compiled_code,
            cast(failures as string) as failures,
            cast(query_id as string) as query_id,
            cast(thread_id as string) as thread_id
        from source

    ),
    final as (
        select
            model_execution_id,
            unique_id,
            invocation_id,
            generated_at,
            name,
            message,
            status,
            resource_type,
            execution_time,
            execute_started_at,
            execute_completed_at,
            compile_started_at,
            compile_completed_at,
            rows_affected,
            full_refresh,
            compiled_code,
            failures,
            query_id,
            thread_id
        from cast_datatypes
    )

select *
from final
