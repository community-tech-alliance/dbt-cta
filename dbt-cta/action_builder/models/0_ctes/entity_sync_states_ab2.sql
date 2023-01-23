{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('entity_sync_states_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(last_run as {{ dbt_utils.type_bigint() }}) as last_run,
    cast(entity_id as {{ dbt_utils.type_bigint() }}) as entity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(comparable_id as {{ dbt_utils.type_bigint() }}) as comparable_id,
    cast(comparable_type as {{ dbt_utils.type_string() }}) as comparable_type,
    cast(external_entity_id as {{ dbt_utils.type_string() }}) as external_entity_id,
    cast(external_compared_id as {{ dbt_utils.type_string() }}) as external_compared_id,
    cast(external_compared_type as {{ dbt_utils.type_string() }}) as external_compared_type,
    cast(service_integration_type as {{ dbt_utils.type_string() }}) as service_integration_type,
    cast(organization_integration_id as {{ dbt_utils.type_bigint() }}) as organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('entity_sync_states_ab1') }}
-- entity_sync_states
where 1 = 1

