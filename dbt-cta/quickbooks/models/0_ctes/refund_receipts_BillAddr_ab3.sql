{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_BillAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_refund_receipts_hashid',
        'Line4',
        'Long',
        'Id',
        'Line1',
        'Lat',
        'Line2',
        'Line3',
    ]) }} as _airbyte_BillAddr_hashid,
    tmp.*
from {{ ref('refund_receipts_BillAddr_ab2') }} as tmp
-- BillAddr at refund_receipts/BillAddr
where 1 = 1
