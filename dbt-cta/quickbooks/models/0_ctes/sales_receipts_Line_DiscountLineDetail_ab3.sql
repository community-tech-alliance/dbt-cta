{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_Line_DiscountLineDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_Line_hashid',
        boolean_to_string('PercentBased'),
        object_to_string('DiscountAccountRef'),
        'DiscountPercent',
    ]) }} as _airbyte_DiscountLineDetail_hashid,
    tmp.*
from {{ ref('sales_receipts_Line_DiscountLineDetail_ab2') }} as tmp
-- DiscountLineDetail at sales_receipts/Line/DiscountLineDetail
where 1 = 1
