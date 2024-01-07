{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_registration_scan_batch_cover_sheets') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    voter_registration_scan_batch_id,
    created_at,
    id,
    file_data,
   {{ dbt_utils.surrogate_key([
     'voter_registration_scan_batch_id',
    'id',
    'file_data'
    ]) }} as _airbyte_voter_registration_scan_batch_cover_sheets_hashid
from {{ source('cta', 'voter_registration_scan_batch_cover_sheets') }}
