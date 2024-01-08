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
    scans_count,
    needs_separation,
    qc_deadline,
    scans_with_phones_count,
    created_at,
    created_by_user_id,
    file_data,
    separating_at,
    scans_need_delivery,
    separating,
    original_filename,
    file_hash,
    updated_at,
    shift_id,
    id,
    ocr,
    assignee_id,
    file_locator,
    van_batch_id,
   {{ dbt_utils.surrogate_key([
     'scans_count',
    'needs_separation',
    'scans_with_phones_count',
    'created_by_user_id',
    'file_data',
    'scans_need_delivery',
    'separating',
    'original_filename',
    'file_hash',
    'shift_id',
    'id',
    'ocr',
    'assignee_id',
    'file_locator',
    'van_batch_id'
    ]) }} as _airbyte_voter_registration_scan_batches_hashid
from {{ source('cta', 'voter_registration_scan_batches') }}
