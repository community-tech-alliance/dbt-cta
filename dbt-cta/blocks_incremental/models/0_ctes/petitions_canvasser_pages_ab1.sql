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
    signed_in,
    canvasser_id,
    sign_out_date,
    extras,
    created_at,
    book_id,
    sign_in_date,
    scan_file_data,
    program_type,
    updated_at,
    signed_out,
    shift_id,
    organization_id,
    id,
   {{ dbt_utils.surrogate_key([
     'signed_in',
    'canvasser_id',
    'sign_out_date',
    'extras',
    'book_id',
    'sign_in_date',
    'scan_file_data',
    'program_type',
    'signed_out',
    'shift_id',
    'organization_id',
    'id'
    ]) }} as _airbyte_petitions_canvasser_pages_hashid
from {{ source('cta', 'petitions_canvasser_pages') }}
