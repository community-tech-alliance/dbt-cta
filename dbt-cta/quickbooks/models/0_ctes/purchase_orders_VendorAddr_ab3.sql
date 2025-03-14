{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_VendorAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchase_orders_hashid',
        'Line4',
        'Long',
        'Country',
        'Id',
        'City',
        'Line1',
        'Lat',
        'Line2',
        'Line3',
    ]) }} as _airbyte_VendorAddr_hashid,
    tmp.*
from {{ ref('purchase_orders_VendorAddr_ab2') }} as tmp
-- VendorAddr at purchase_orders/VendorAddr
where 1 = 1
