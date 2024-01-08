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
    list_folder_id,
    query,
    search_params,
    created_at,
    repopulation_status,
    primary_emails_count,
    people_count,
    queryable,
    phones_count,
    updated_at,
    refreshed_at,
    user_id,
    name,
    id,
    households_count,
   {{ dbt_utils.surrogate_key([
     'list_folder_id',
    'query',
    'search_params',
    'repopulation_status',
    'primary_emails_count',
    'people_count',
    'queryable',
    'phones_count',
    'user_id',
    'name',
    'id',
    'households_count'
    ]) }} as _airbyte_lists_hashid
from {{ source('cta', 'lists') }}
