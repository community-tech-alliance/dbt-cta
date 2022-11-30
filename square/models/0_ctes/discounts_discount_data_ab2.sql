{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('discounts_discount_data_ab1') }}
select
    _airbyte_discounts_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(percentage as {{ dbt_utils.type_string() }}) as percentage,
    cast(amount_money as {{ type_json() }}) as amount_money,
    {{ cast_to_boolean('pin_required') }} as pin_required,
    cast(discount_type as {{ dbt_utils.type_string() }}) as discount_type,
    cast(modify_tax_basis as {{ dbt_utils.type_string() }}) as modify_tax_basis,
    cast(application_method as {{ dbt_utils.type_string() }}) as application_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('discounts_discount_data_ab1') }}
-- discount_data at discounts/discount_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

