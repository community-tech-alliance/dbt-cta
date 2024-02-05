{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'teachers') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    congressional_district,
    customer_address_id,
    city,
    latitude,
    state_senate_district,
    last_name,
    created_at,
    address_two,
    county_name,
    zipcode,
    county_fips,
    updated_at,
    state_house_district,
    address_one,
    census_block,
    organization_id,
    id,
    state,
    first_name,
    longitude,
    person_id,
   {{ dbt_utils.surrogate_key([
     'congressional_district',
    'customer_address_id',
    'city',
    'state_senate_district',
    'last_name',
    'address_two',
    'county_name',
    'zipcode',
    'county_fips',
    'state_house_district',
    'address_one',
    'census_block',
    'organization_id',
    'id',
    'state',
    'first_name',
    'person_id'
    ]) }} as _airbyte_teachers_hashid
from {{ source('cta', 'teachers') }}
