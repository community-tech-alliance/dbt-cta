{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'documents') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    user_id,
    folder_id,
    tenant_id,
    created_at,
    updated_at,
    file_locator,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'user_id',
    'folder_id',
    'tenant_id',
    'file_locator'
    ]) }} as _airbyte_documents_hashid
from {{ source('cta', 'documents') }}
