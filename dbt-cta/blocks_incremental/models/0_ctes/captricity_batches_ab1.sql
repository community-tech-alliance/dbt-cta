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
    rejected_at,
    submitted_at,
    voter_registration_scan_batch_id,
    remote_id,
    created_at,
    reject_reason,
    petition_packet_id,
    api_log,
    imported_at,
    updated_at,
    petitions_book_id,
    id,
    status,
   {{ dbt_utils.surrogate_key([
     'voter_registration_scan_batch_id',
    'remote_id',
    'reject_reason',
    'petition_packet_id',
    'api_log',
    'petitions_book_id',
    'id',
    'status'
    ]) }} as _airbyte_captricity_batches_hashid
from {{ source('cta', 'captricity_batches') }}
