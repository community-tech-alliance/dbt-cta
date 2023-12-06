{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'zip',
        'country',
        'city',
        'latitude',
        'region_id',
        'country_code',
        'street',
        'name',
        'located_in',
        'state',
        'region',
        'city_id',
        'longitude',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('page_location_ab2') }} tmp
-- location at page/location
where 1 = 1

