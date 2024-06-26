{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petitions_canvasser_pages') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    extras,
    book_id,
    shift_id,
    signed_in,
    created_at,
    signed_out,
    updated_at,
    canvasser_id,
    program_type,
    sign_in_date,
    sign_out_date,
    scan_file_data,
    organization_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'extras',
    'book_id',
    'shift_id',
    'signed_in',
    'signed_out',
    'canvasser_id',
    'program_type',
    'sign_in_date',
    'sign_out_date',
    'scan_file_data',
    'organization_id'
    ]) }} as _airbyte_petitions_canvasser_pages_hashid
from {{ source('cta', 'petitions_canvasser_pages') }}
