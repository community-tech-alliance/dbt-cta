{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'user_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_location') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   user_id,
   latitude,
   loc_code,
   timezone,
   longitude,
   us_county,
   created_at,
   updated_at,
   region_code,
   us_district,
   country_code,
   _ab_cdc_cursor,
   _ab_cdc_log_pos,
   us_state_senate,
   _ab_cdc_log_file,
   lat_lon_precision,
   us_state_district,
   _ab_cdc_deleted_at,
   _ab_cdc_updated_at
from {{ source('cta', 'core_location') }}
