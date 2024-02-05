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
    sluggable_type,
    scope,
    sluggable_id,
    created_at,
    id,
    slug,
   {{ dbt_utils.surrogate_key([
     'sluggable_type',
    'scope',
    'sluggable_id',
    'id',
    'slug'
    ]) }} as _airbyte_friendly_id_slugs_hashid
from {{ source('cta', 'friendly_id_slugs') }}
