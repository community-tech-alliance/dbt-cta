
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
   id,
   row_data,
   import_id,
   duplicate_found,
   errors_triggered,
   {{ dbt_utils.surrogate_key([
     'id',
    'row_data',
    'import_id',
    'duplicate_found',
    'errors_triggered'
    ]) }} as _airbyte_imports_error_rows_hashid
from {{ source('cta', 'imports_error_rows') }}