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
    tenant_id,
    updated_at,
    user_id,
    file_name_data,
    created_at,
    id,
    encoding,
    file_size,
    row_count,
   {{ dbt_utils.surrogate_key([
     'tenant_id',
    'user_id',
    'file_name_data',
    'id',
    'encoding',
    'file_size',
    'row_count'
    ]) }} as _airbyte_import_files_hashid
from {{ source('cta', 'import_files') }}
