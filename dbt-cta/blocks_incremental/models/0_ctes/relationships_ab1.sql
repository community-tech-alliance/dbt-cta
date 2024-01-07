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
    first_person_id,
    updated_at,
    relationship_type_id,
    second_person_id,
    created_at,
    id,
    type,
   {{ dbt_utils.surrogate_key([
     'first_person_id',
    'relationship_type_id',
    'second_person_id',
    'id',
    'type'
    ]) }} as _airbyte_relationships_hashid
from {{ source('cta', 'relationships') }}
