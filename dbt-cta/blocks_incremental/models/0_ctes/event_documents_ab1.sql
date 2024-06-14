{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'event_documents') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    event_id,
    folder_id,
    created_at,
    updated_at,
    document_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'event_id',
    'folder_id',
    'document_id'
    ]) }} as _airbyte_event_documents_hashid
from {{ source('cta', 'event_documents') }}
