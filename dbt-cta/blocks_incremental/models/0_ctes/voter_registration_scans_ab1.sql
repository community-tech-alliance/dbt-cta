
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_registration_scans') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   remote_captricity_batch_file_id,
   notes,
   reviewed_by_user_id,
   voter_registration_scan_batch_id,
   delivery_id,
   reviewed_at,
   county,
   created_at,
   jpg_data,
   scan_number,
   updated_at,
   turn_in_location_id,
   digitization_data,
   id,
   file_locator,
   {{ dbt_utils.surrogate_key([
     'remote_captricity_batch_file_id',
    'notes',
    'reviewed_by_user_id',
    'voter_registration_scan_batch_id',
    'delivery_id',
    'county',
    'jpg_data',
    'scan_number',
    'turn_in_location_id',
    'digitization_data',
    'id',
    'file_locator'
    ]) }} as _airbyte_voter_registration_scans_hashid
from {{ source('cta', 'voter_registration_scans') }}