{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'captricity_batches') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    status,
    api_log,
    jobs_log,
    remote_id,
    created_at,
    updated_at,
    imported_at,
    rejected_at,
    submitted_at,
    reject_reason,
    petitions_book_id,
    petition_packet_id,
    voter_registration_scan_batch_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'status',
    'api_log',
    'remote_id',
    'reject_reason',
    'petitions_book_id',
    'petition_packet_id',
    'voter_registration_scan_batch_id'
    ]) }} as _airbyte_captricity_batches_hashid
from {{ source('cta', 'captricity_batches') }}
