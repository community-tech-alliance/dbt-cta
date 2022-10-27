{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_package_dimensions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        'width',
        'height',
        'length',
        'weight',
    ]) }} as _airbyte_package_dimensions_hashid,
    tmp.*
from {{ ref('products_package_dimensions_ab2') }} tmp
-- package_dimensions at products/package_dimensions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

