
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'addresses') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   line_three,
   city,
   line_one,
   county,
   coordinates,
   created_at,
   zipcode,
   county_id,
   updated_at,
   line_four,
   id,
   state,
   district_config,
   line_two,
   tsv_full_address,
   {{ dbt_utils.surrogate_key([
     'line_three',
    'city',
    'line_one',
    'county',
    'coordinates',
    'zipcode',
    'county_id',
    'line_four',
    'id',
    'state',
    'district_config',
    'line_two',
    'tsv_full_address'
    ]) }} as _airbyte_addresses_hashid
from {{ source('cta', 'addresses') }}