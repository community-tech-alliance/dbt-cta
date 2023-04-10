{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_total_details_breakdown_taxes_rate_ab1') }}
select
    _airbyte_taxes_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    {{ cast_to_boolean('active') }} as active,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(tax_type as {{ dbt_utils.type_string() }}) as tax_type,
    {{ cast_to_boolean('inclusive') }} as inclusive,
    cast(percentage as {{ dbt_utils.type_float() }}) as percentage,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(display_name as {{ dbt_utils.type_string() }}) as display_name,
    cast(jurisdiction as {{ dbt_utils.type_string() }}) as jurisdiction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_total_details_breakdown_taxes_rate_ab1') }}
-- rate at checkout_sessions_base/total_details/breakdown/taxes/rate
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

