
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
   tenant_id,
   updated_at,
   user_id,
   name,
   created_at,
   id,
   folder_id,
   file_locator,
   {{ dbt_utils.surrogate_key([
     'tenant_id',
    'user_id',
    'name',
    'id',
    'folder_id',
    'file_locator'
    ]) }} as _airbyte_documents_hashid
from {{ source('cta', 'documents') }}