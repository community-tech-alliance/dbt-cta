{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'name',
        'created_at',
        'updated_at',
        'description',
    ]) }} as _airbyte_products_hashid,
    tmp.*
from {{ ref('product_ab2') }} tmp
-- products
where 1 = 1

