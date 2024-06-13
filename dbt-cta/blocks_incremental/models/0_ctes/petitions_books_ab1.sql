
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
   id,
   status,
   user_id,
   shift_id,
   notary_id,
   created_at,
   updated_at,
   program_type,
   scan_file_data,
   canvasser_page_id,
   scan_file_filename,
   petition_book_number,
   {{ dbt_utils.surrogate_key([
     'id',
    'status',
    'user_id',
    'shift_id',
    'notary_id',
    'program_type',
    'scan_file_data',
    'canvasser_page_id',
    'scan_file_filename',
    'petition_book_number'
    ]) }} as _airbyte_petitions_books_hashid
from {{ source('cta', 'petitions_books') }}