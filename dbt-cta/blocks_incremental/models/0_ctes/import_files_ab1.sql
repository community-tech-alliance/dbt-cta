{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'import_files') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    user_id,
    encoding,
    file_size,
    row_count,
    tenant_id,
    created_at,
    updated_at,
    file_name_data,
   {{ dbt_utils.surrogate_key([
     'id',
    'user_id',
    'encoding',
    'file_size',
    'row_count',
    'tenant_id',
    'file_name_data'
    ]) }} as _airbyte_import_files_hashid
from {{ source('cta', 'import_files') }}
