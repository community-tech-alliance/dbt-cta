{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_Line_SalesItemLineDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_Line_hashid',
        'UnitPrice',
        object_to_string('TaxCodeRef'),
        'Qty',
        object_to_string('ItemRef'),
    ]) }} as _airbyte_SalesItemLineDetail_hashid,
    tmp.*
from {{ ref('refund_receipts_Line_SalesItemLineDetail_ab2') }} as tmp
-- SalesItemLineDetail at refund_receipts/Line/SalesItemLineDetail
where 1 = 1
