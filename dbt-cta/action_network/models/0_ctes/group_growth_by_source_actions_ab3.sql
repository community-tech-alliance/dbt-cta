{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('group_growth_by_source_actions_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'end_at',
        'group_id',
        'start_at',
        'created_at',
        'updated_at',
        'total_count',
        'new_users_count',
        'source_action_id',
        'source_action_type',
        'last_subscription_id',
    ]) }} as _airbyte_group_growth_by_source_actions_hashid,
    tmp.*
from {{ ref('group_growth_by_source_actions_ab2') }} as tmp
-- group_growth_by_source_actions
where 1 = 1
