{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('delayed_jobs_ab1') }}
select
    cast(handler as {{ dbt_utils.type_string() }}) as handler,
    cast(locked_by as {{ dbt_utils.type_string() }}) as locked_by,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('locked_at') }} as {{ type_timestamp_without_timezone() }}) as locked_at,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('run_at') }} as {{ type_timestamp_without_timezone() }}) as run_at,
    cast({{ empty_string_to_null('failed_at') }} as {{ type_timestamp_without_timezone() }}) as failed_at,
    cast(last_error as {{ dbt_utils.type_string() }}) as last_error,
    cast(priority as {{ dbt_utils.type_bigint() }}) as priority,
    cast(queue as {{ dbt_utils.type_string() }}) as queue,
    cast(attempts as {{ dbt_utils.type_bigint() }}) as attempts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('delayed_jobs_ab1') }}
-- delayed_jobs
where 1 = 1
