{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'list_folders_users') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    user_id,
    list_folder_id,
   {{ dbt_utils.surrogate_key([
     'user_id',
    'list_folder_id'
    ]) }} as _airbyte_list_folders_users_hashid
from {{ source('cta', 'list_folders_users') }}
