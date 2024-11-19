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
    id,
    status,
    list_id,
    mapping,
    user_id,
    filename,
    mappings,
    created_at,
    updated_at,
    worker_jid,
    for_phone_bank,
    imported_rows_count,
    stored_spreadsheet_data,
    original_spreadsheet_data,
   {{ dbt_utils.surrogate_key([
     'id',
    'status',
    'list_id',
    'mapping',
    'user_id',
    'filename',
    'mappings',
    'worker_jid',
    'for_phone_bank',
    'imported_rows_count',
    'stored_spreadsheet_data',
    'original_spreadsheet_data'
    ]) }} as _airbyte_imports_hashid
from {{ source('cta', 'imports') }}
