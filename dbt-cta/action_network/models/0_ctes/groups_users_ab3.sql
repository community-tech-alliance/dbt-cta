{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('groups_users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'hidden',
        'user_id',
        'approved',
        'group_id',
        'is_leader',
        'created_at',
        'updated_at',
        'first_visit',
        'join_message',
        'user_permissions',
    ]) }} as _airbyte_groups_users_hashid,
    tmp.*
from {{ ref('groups_users_ab2') }} as tmp
-- groups_users
where 1 = 1
