{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_PurchaseEx_any_value_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_any_hashid',
        'Value',
        'Name',
    ]) }} as _airbyte_value_hashid,
    tmp.*
from {{ ref('purchases_PurchaseEx_any_value_ab2') }} as tmp
-- value at purchases/PurchaseEx/any/value
where 1 = 1
