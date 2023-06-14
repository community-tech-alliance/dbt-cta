{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('job_request_ab1') }}
select
    cast(job_type as {{ dbt_utils.type_string() }}) as job_type,
    cast(queue_name as {{ dbt_utils.type_string() }}) as queue_name,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(result_message as {{ dbt_utils.type_string() }}) as result_message,
    cast(payload as {{ dbt_utils.type_string() }}) as payload,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    {{ cast_to_boolean('assigned') }} as assigned,
    {{ cast_to_boolean('locks_queue') }} as locks_queue,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(status as {{ dbt_utils.type_bigint() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('job_request_ab1') }}
-- job_request
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

