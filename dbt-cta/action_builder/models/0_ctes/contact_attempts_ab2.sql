{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('contact_attempts_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(action_id as {{ dbt_utils.type_bigint() }}) as action_id,
    cast(entity_id as {{ dbt_utils.type_bigint() }}) as entity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(disposition as {{ dbt_utils.type_bigint() }}) as disposition,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(contact_info_id as {{ dbt_utils.type_bigint() }}) as contact_info_id,
    cast(action_entity_id as {{ dbt_utils.type_bigint() }}) as action_entity_id,
    cast(contact_info_type as {{ dbt_utils.type_string() }}) as contact_info_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('contact_attempts_ab1') }}
-- contact_attempts
where 1 = 1
