{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'folders') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    depth,
    updated_at,
    parent_id,
    name,
    extras,
    created_at,
    id,
    lft,
    rgt,
   {{ dbt_utils.surrogate_key([
     'depth',
    'parent_id',
    'name',
    'extras',
    'id',
    'lft',
    'rgt'
    ]) }} as _airbyte_folders_hashid
from {{ source('cta', 'folders') }}
