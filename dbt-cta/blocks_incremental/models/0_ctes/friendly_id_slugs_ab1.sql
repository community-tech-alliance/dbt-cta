
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'friendly_id_slugs') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   slug,
   scope,
   created_at,
   sluggable_id,
   sluggable_type,
   {{ dbt_utils.surrogate_key([
     'id',
    'slug',
    'scope',
    'sluggable_id',
    'sluggable_type'
    ]) }} as _airbyte_friendly_id_slugs_hashid
from {{ source('cta', 'friendly_id_slugs') }}