
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'collections') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   `name`,
   `default`,
   created_at,
   updated_at,
   collection_type,
   created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'default',
    'collection_type',
    'created_by_user_id'
    ]) }} as _airbyte_collections_hashid
from {{ source('cta', 'collections') }}