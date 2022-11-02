{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'created_at',
        'updated_at',
        'description',
    ]) }} as _airbyte_products_hashid,
    tmp.*
from {{ ref('products_ab2') }} tmp
-- products
where 1 = 1

