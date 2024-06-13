
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'groupings') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   name,
   position,
   created_at,
   updated_at,
   description,
   collection_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'position',
    'description',
    'collection_id'
    ]) }} as _airbyte_groupings_hashid
from {{ source('cta', 'groupings') }}