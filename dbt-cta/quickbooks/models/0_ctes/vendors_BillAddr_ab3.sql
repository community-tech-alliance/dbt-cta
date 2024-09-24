{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendors_BillAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_vendors_hashid',
        'CountrySubDivisionCode',
        'Long',
        'Country',
        'PostalCode',
        'Id',
        'City',
        'Line1',
        'Lat',
    ]) }} as _airbyte_BillAddr_hashid,
    tmp.*
from {{ ref('vendors_BillAddr_ab2') }} as tmp
-- BillAddr at vendors/BillAddr
where 1 = 1
