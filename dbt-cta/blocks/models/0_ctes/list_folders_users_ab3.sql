{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('list_folders_users_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'user_id',
        'list_folder_id',
    ]) }} as _airbyte_list_folders_users_hashid,
    tmp.*
from {{ ref('list_folders_users_ab2') }} tmp
-- list_folders_users
where 1 = 1

