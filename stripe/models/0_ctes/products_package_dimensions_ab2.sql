{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_package_dimensions_ab1') }}
select
    _airbyte_products_hashid,
    cast(width as {{ dbt_utils.type_float() }}) as width,
    cast(height as {{ dbt_utils.type_float() }}) as height,
    cast(length as {{ dbt_utils.type_float() }}) as length,
    cast(weight as {{ dbt_utils.type_float() }}) as weight,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_package_dimensions_ab1') }}
-- package_dimensions at products/package_dimensions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

