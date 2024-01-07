
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'versions') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   item_id,
   item_type,
   object_yaml,
   created_at,
   id,
   event,
   whodunnit,
   object,
   {{ dbt_utils.surrogate_key([
     'item_id',
    'item_type',
    'object_yaml',
    'id',
    'event',
    'whodunnit',
    'object'
    ]) }} as _airbyte_versions_hashid
from {{ source('cta', 'versions') }}