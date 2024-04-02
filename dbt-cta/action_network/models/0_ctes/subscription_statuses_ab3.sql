{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('subscription_statuses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'status',
        'user_id',
        'group_id',
        'join_date',
        'created_at',
        'updated_at',
        'subscriber_id',
        'source_action_id',
        'source_action_type',
    ]) }} as _airbyte_subscription_statuses_hashid,
    tmp.*
from {{ ref('subscription_statuses_ab2') }} as tmp
-- subscription_statuses
where 1 = 1
