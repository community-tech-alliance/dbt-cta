{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_Line_ItemBasedExpenseLineDetail_TaxCodeRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ItemBasedExpenseLineDetail_hashid',
        'value',
    ]) }} as _airbyte_TaxCodeRef_hashid,
    tmp.*
from {{ ref('purchases_Line_ItemBasedExpenseLineDetail_TaxCodeRef_ab2') }} as tmp
-- TaxCodeRef at purchases/Line/ItemBasedExpenseLineDetail/TaxCodeRef
where 1 = 1
