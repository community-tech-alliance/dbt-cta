{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'venues') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    address_id,
    created_at,
    it_support,
    updated_at,
    hosted_event,
    largest_size,
    maximum_size,
    parking_spots,
    rooms_available,
    public_transportation,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'address_id',
    'it_support',
    'hosted_event',
    'largest_size',
    'maximum_size',
    'parking_spots',
    'rooms_available',
    'public_transportation'
    ]) }} as _airbyte_venues_hashid
from {{ source('cta', 'venues') }}
