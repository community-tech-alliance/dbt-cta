{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'notes') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    created_at,
    id,
    created_by_user_id,
    content,
    person_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'created_by_user_id',
    'content',
    'person_id'
    ]) }} as _airbyte_notes_hashid
from {{ source('cta', 'notes') }}
