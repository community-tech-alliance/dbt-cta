{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('mobile_message_fields_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(text as {{ dbt_utils.type_string() }}) as text,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(field_type as {{ dbt_utils.type_string() }}) as field_type,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(mobile_message_id as {{ dbt_utils.type_bigint() }}) as mobile_message_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('mobile_message_fields_ab1') }}
-- mobile_message_fields
where 1 = 1
