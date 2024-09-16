{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_ARAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ARAccountRef_hashid,
    tmp.*
from {{ ref('payments_ARAccountRef_ab2') }} as tmp
-- ARAccountRef at payments/ARAccountRef
where 1 = 1
