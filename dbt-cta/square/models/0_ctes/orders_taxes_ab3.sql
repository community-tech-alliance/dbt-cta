{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_taxes_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_orders_hashid',
        'uid',
        'name',
        'type',
        'scope',
        'percentage',
        object_to_string('applied_money'),
        'catalog_object_id',
    ]) }} as _airbyte_taxes_hashid,
    tmp.*
from {{ ref('orders_taxes_ab2') }} as tmp
-- taxes at orders/taxes
where 1 = 1
