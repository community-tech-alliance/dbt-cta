
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
   maximum_size,
   rooms_available,
   updated_at,
   name,
   address_id,
   it_support,
   largest_size,
   created_at,
   public_transportation,
   id,
   parking_spots,
   hosted_event,
   {{ dbt_utils.surrogate_key([
     'maximum_size',
    'rooms_available',
    'name',
    'address_id',
    'it_support',
    'largest_size',
    'public_transportation',
    'id',
    'parking_spots',
    'hosted_event'
    ]) }} as _airbyte_venues_hashid
from {{ source('cta', 'venues') }}