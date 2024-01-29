{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_BillAddr_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_customers_hashid',
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
from {{ ref('customers_BillAddr_ab2') }} tmp
-- BillAddr at customers/BillAddr
where 1 = 1

