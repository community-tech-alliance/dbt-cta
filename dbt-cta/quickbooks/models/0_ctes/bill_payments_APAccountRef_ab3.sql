{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_APAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_bill_payments_hashid',
        'name',
        'value',
    ]) }} as _airbyte_APAccountRef_hashid,
    tmp.*
from {{ ref('bill_payments_APAccountRef_ab2') }} as tmp
-- APAccountRef at bill_payments/APAccountRef
where 1 = 1
