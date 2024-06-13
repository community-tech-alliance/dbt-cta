
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
   id,
   city,
   state,
   county,
   zipcode,
   line_one,
   line_two,
   county_id,
   line_four,
   created_at,
   line_three,
   updated_at,
   coordinates,
   district_config,
   tsv_full_address,
   {{ dbt_utils.surrogate_key([
     'id',
    'city',
    'state',
    'county',
    'zipcode',
    'line_one',
    'line_two',
    'county_id',
    'line_four',
    'line_three',
    'coordinates',
    'district_config',
    'tsv_full_address'
    ]) }} as _airbyte_addresses_hashid
from {{ source('cta', 'addresses') }}