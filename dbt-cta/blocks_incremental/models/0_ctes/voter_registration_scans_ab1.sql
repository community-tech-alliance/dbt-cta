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
    id,
    notes,
    county,
    jpg_data,
    created_at,
    updated_at,
    delivery_id,
    reviewed_at,
    scan_number,
    file_locator,
    digitization_data,
    reviewed_by_user_id,
    turn_in_location_id,
    remote_captricity_batch_file_id,
    voter_registration_scan_batch_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'notes',
    'county',
    'jpg_data',
    'delivery_id',
    'scan_number',
    'file_locator',
    'digitization_data',
    'reviewed_by_user_id',
    'turn_in_location_id',
    'remote_captricity_batch_file_id',
    'voter_registration_scan_batch_id'
    ]) }} as _airbyte_voter_registration_scans_hashid
from {{ source('cta', 'voter_registration_scans') }}
