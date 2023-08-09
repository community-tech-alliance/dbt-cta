{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_ShipAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
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
from {{ ref('customers_ShipAddr_ab2') }} tmp
-- ShipAddr at customers/ShipAddr
where 1 = 1

