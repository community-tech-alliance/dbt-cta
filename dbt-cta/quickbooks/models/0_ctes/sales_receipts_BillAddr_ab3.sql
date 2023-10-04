{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_BillAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_sales_receipts_hashid',
        'Line4',
        'Long',
        'Id',
        'Line1',
        'Lat',
        'Line2',
        'Line3',
    ]) }} as _airbyte_BillAddr_hashid,
    tmp.*
from {{ ref('sales_receipts_BillAddr_ab2') }} tmp
-- BillAddr at sales_receipts/BillAddr
where 1 = 1

