{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'lists') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    query,
    user_id,
    queryable,
    created_at,
    updated_at,
    people_count,
    phones_count,
    refreshed_at,
    search_params,
    list_folder_id,
    households_count,
    repopulation_status,
    primary_emails_count,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'query',
    'user_id',
    'queryable',
    'people_count',
    'phones_count',
    'search_params',
    'list_folder_id',
    'households_count',
    'repopulation_status',
    'primary_emails_count'
    ]) }} as _airbyte_lists_hashid
from {{ source('cta', 'lists') }}
