{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendor_credits_Line_AccountBasedExpenseLineDetail_ClassRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_AccountBasedExpenseLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ClassRef_hashid,
    tmp.*
from {{ ref('vendor_credits_Line_AccountBasedExpenseLineDetail_ClassRef_ab2') }} as tmp
-- ClassRef at vendor_credits/Line/AccountBasedExpenseLineDetail/ClassRef
where 1 = 1
