{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_package_dimensions_ab3') }}
select
    _airbyte_products_hashid,
    width,
    height,
    length,
    weight,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_package_dimensions_hashid
from {{ ref('products_package_dimensions_ab3') }}
-- package_dimensions at products_base/package_dimensions from {{ ref('products_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

