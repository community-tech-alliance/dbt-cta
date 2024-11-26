{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'searches') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    query,
    extras,
    created_at,
    updated_at,
    current_list,
    search_params,
    created_by_user_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'query',
    'extras',
    'search_params',
    'created_by_user_id'
    ]) }} as _airbyte_searches_hashid
from {{ source('cta', 'searches') }}
