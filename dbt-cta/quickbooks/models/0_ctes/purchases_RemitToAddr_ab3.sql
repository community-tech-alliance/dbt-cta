{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_RemitToAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchases_hashid',
        'CountrySubDivisionCode',
        'Long',
        'PostalCode',
        'Id',
        'City',
        'Line1',
        'Lat',
    ]) }} as _airbyte_RemitToAddr_hashid,
    tmp.*
from {{ ref('purchases_RemitToAddr_ab2') }} tmp
-- RemitToAddr at purchases/RemitToAddr
where 1 = 1

