{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('locations_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_locations_hashid',
        'country',
        'locality',
        'postal_code',
        'address_line_1',
        'administrative_district_level_1',
    ]) }} as _airbyte_address_hashid,
    tmp.*
from {{ ref('locations_address_ab2') }} tmp
-- address at locations/address
where 1 = 1

