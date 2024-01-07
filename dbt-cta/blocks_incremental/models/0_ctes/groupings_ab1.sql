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
    collection_id,
    updated_at,
    name,
    created_at,
    description,
    id,
    position,
   {{ dbt_utils.surrogate_key([
     'collection_id',
    'name',
    'description',
    'id',
    'position'
    ]) }} as _airbyte_groupings_hashid
from {{ source('cta', 'groupings') }}
