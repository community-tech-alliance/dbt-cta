{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contact_methods') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    extension,
    contact_type,
    updated_at,
    invalid,
    created_at,
    description,
    id,
    content,
    person_id,
   {{ dbt_utils.surrogate_key([
     'extension',
    'contact_type',
    'invalid',
    'description',
    'id',
    'content',
    'person_id'
    ]) }} as _airbyte_contact_methods_hashid
from {{ source('cta', 'contact_methods') }}
