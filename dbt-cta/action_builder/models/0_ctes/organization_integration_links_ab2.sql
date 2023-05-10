{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organization_integration_links_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(settings as {{ dbt_utils.type_string() }}) as settings,
    cast(parent_id as {{ dbt_utils.type_bigint() }}) as parent_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(linkable_id as {{ dbt_utils.type_bigint() }}) as linkable_id,
    cast(linkable_type as {{ dbt_utils.type_string() }}) as linkable_type,
    cast(external_entity_id as {{ dbt_utils.type_string() }}) as external_entity_id,
    cast(external_entity_type as {{ dbt_utils.type_string() }}) as external_entity_type,
    cast(organization_integration_id as {{ dbt_utils.type_bigint() }}) as organization_integration_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organization_integration_links_ab1') }}
-- organization_integration_links
where 1 = 1

