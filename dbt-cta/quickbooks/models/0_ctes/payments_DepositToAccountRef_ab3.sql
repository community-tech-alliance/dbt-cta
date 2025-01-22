{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_DepositToAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payments_hashid',
        'value',
    ]) }} as _airbyte_DepositToAccountRef_hashid,
    tmp.*
from {{ ref('payments_DepositToAccountRef_ab2') }} as tmp
-- DepositToAccountRef at payments/DepositToAccountRef
where 1 = 1
