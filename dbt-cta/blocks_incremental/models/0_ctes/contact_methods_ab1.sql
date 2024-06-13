
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
   id,
   content,
   invalid,
   extension,
   person_id,
   created_at,
   updated_at,
   description,
   contact_type,
   {{ dbt_utils.surrogate_key([
     'id',
    'content',
    'invalid',
    'extension',
    'person_id',
    'description',
    'contact_type'
    ]) }} as _airbyte_contact_methods_hashid
from {{ source('cta', 'contact_methods') }}