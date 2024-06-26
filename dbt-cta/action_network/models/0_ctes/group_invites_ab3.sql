{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('group_invites_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'email',
        'accepted',
        'group_id',
        'created_at',
        'inviter_id',
        'updated_at',
    ]) }} as _airbyte_group_invites_hashid,
    tmp.*
from {{ ref('group_invites_ab2') }} as tmp
-- group_invites
where 1 = 1
