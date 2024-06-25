{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'filter_views') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    rules,
    user_id,
    metadata,
    created_at,
    updated_at,
    conjunction,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'rules',
    'user_id',
    'metadata',
    'conjunction'
    ]) }} as _airbyte_filter_views_hashid
from {{ source('cta', 'filter_views') }}
