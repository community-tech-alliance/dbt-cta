
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'search_documents') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   search_id,
   created_at,
   updated_at,
   document_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'search_id',
    'document_id'
    ]) }} as _airbyte_search_documents_hashid
from {{ source('cta', 'search_documents') }}