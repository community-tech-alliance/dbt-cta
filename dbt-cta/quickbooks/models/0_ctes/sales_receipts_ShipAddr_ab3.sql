{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sales_receipts_ShipAddr_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_sales_receipts_hashid',
        'CountrySubDivisionCode',
        'Long',
        'Country',
        'PostalCode',
        'Id',
        'City',
        'Line1',
        'Lat',
    ]) }} as _airbyte_ShipAddr_hashid,
    tmp.*
from {{ ref('sales_receipts_ShipAddr_ab2') }} tmp
-- ShipAddr at sales_receipts/ShipAddr
where 1 = 1

