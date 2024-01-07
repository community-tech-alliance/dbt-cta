
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'imports_error_rows') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   errors_triggered,
   import_id,
   id,
   row_data,
   duplicate_found,
   {{ dbt_utils.surrogate_key([
     'errors_triggered',
    'import_id',
    'id',
    'row_data',
    'duplicate_found'
    ]) }} as _airbyte_imports_error_rows_hashid
from {{ source('cta', 'imports_error_rows') }}