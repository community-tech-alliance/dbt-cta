{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('groups_syndications_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'read',
        'email_id',
        'group_id',
        'notified',
        'action_id',
        'created_at',
        'updated_at',
        'action_type',
        'syndication_id',
    ]) }} as _airbyte_groups_syndications_hashid,
    tmp.*
from {{ ref('groups_syndications_ab2') }} as tmp
-- groups_syndications
where 1 = 1
