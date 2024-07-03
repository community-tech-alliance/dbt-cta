{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_registration_scan_batches') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    ocr,
    shift_id,
    file_data,
    file_hash,
    separated,
    created_at,
    assignee_id,
    qc_deadline,
    scans_count,
    file_locator,
    van_batch_id,
    needs_separation,
    original_filename,
    created_by_user_id,
    scans_with_phones_count,
   {{ dbt_utils.surrogate_key([
    'id',
    'ocr',
    'shift_id',
    'file_data',
    'file_hash',
    'separated',
    'assignee_id',
    'qc_deadline',
    'scans_count',
    'file_locator',
    'van_batch_id',
    'needs_separation',
    'original_filename',
    'created_by_user_id',
    'scans_with_phones_count'
    ]) }} as _airbyte_voter_registration_scan_batches_hashid
from {{ source('cta', 'voter_registration_scan_batches') }}
