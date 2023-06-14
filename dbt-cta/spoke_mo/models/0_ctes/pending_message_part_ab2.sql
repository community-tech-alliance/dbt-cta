{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('pending_message_part_ab1') }}
select
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(parent_id as {{ dbt_utils.type_string() }}) as parent_id,
    cast(service_id as {{ dbt_utils.type_string() }}) as service_id,
    cast(service_message as {{ dbt_utils.type_string() }}) as service_message,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(contact_number as {{ dbt_utils.type_string() }}) as contact_number,
    cast(user_number as {{ dbt_utils.type_string() }}) as user_number,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('pending_message_part_ab1') }}
-- pending_message_part
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

