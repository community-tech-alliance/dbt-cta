{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_source_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_orders_hashid',
        'name',
    ]) }} as _airbyte_source_hashid,
    tmp.*
from {{ ref('orders_source_ab2') }} as tmp
-- source at orders/source
where 1 = 1
