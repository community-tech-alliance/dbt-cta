{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petitions_books') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    petition_book_number,
    program_type,
    canvasser_page_id,
    notary_id,
    updated_at,
    user_id,
    shift_id,
    created_at,
    id,
    scan_file_filename,
    scan_file_data,
    status,
   {{ dbt_utils.surrogate_key([
     'petition_book_number',
    'program_type',
    'canvasser_page_id',
    'notary_id',
    'user_id',
    'shift_id',
    'id',
    'scan_file_filename',
    'scan_file_data',
    'status'
    ]) }} as _airbyte_petitions_books_hashid
from {{ source('cta', 'petitions_books') }}
