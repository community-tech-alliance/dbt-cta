
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'imports') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   mapping,
   list_id,
   created_at,
   for_phone_bank,
   stored_spreadsheet_data,
   original_spreadsheet_data,
   imported_rows_count,
   mappings,
   filename,
   updated_at,
   user_id,
   worker_jid,
   id,
   status,
   {{ dbt_utils.surrogate_key([
     'mapping',
    'list_id',
    'for_phone_bank',
    'stored_spreadsheet_data',
    'original_spreadsheet_data',
    'imported_rows_count',
    'mappings',
    'filename',
    'user_id',
    'worker_jid',
    'id',
    'status'
    ]) }} as _airbyte_imports_hashid
from {{ source('cta', 'imports') }}