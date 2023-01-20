{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('link_domain_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(domain as {{ dbt_utils.type_string() }}) as domain,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast({{ empty_string_to_null('cycled_out_at') }} as {{ type_timestamp_with_timezone() }}) as cycled_out_at,
    cast(max_usage_count as {{ dbt_utils.type_bigint() }}) as max_usage_count,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(current_usage_count as {{ dbt_utils.type_bigint() }}) as current_usage_count,
    {{ cast_to_boolean('is_manually_disabled') }} as is_manually_disabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('link_domain_ab1') }}
-- link_domain
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

