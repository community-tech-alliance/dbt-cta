
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'relationships') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   type,
   created_at,
   updated_at,
   first_person_id,
   second_person_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'type',
    'first_person_id',
    'second_person_id'
    ]) }} as _airbyte_relationships_hashid
from {{ source('cta', 'relationships') }}