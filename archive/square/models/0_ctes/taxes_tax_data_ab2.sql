{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('taxes_tax_data_ab1') }}
select
    _airbyte_taxes_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(percentage as {{ dbt_utils.type_string() }}) as percentage,
    cast(tax_type_id as {{ dbt_utils.type_string() }}) as tax_type_id,
    cast(tax_type_name as {{ dbt_utils.type_string() }}) as tax_type_name,
    cast(inclusion_type as {{ dbt_utils.type_string() }}) as inclusion_type,
    cast(calculation_phase as {{ dbt_utils.type_string() }}) as calculation_phase,
    {{ cast_to_boolean('applies_to_custom_amounts') }} as applies_to_custom_amounts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('taxes_tax_data_ab1') }}
-- tax_data at taxes/tax_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

