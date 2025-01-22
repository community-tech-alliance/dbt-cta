{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_Line_SalesItemLineDetail_TaxCodeRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_SalesItemLineDetail_hashid',
        'value',
    ]) }} as _airbyte_TaxCodeRef_hashid,
    tmp.*
from {{ ref('refund_receipts_Line_SalesItemLineDetail_TaxCodeRef_ab2') }} as tmp
-- TaxCodeRef at refund_receipts/Line/SalesItemLineDetail/TaxCodeRef
where 1 = 1
