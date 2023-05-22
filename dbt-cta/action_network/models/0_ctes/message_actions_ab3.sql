{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('message_actions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'referrer',
        'action_id',
        'created_at',
        'sending_id',
        'updated_at',
        'action_type',
        'sending_type',
    ]) }} as _airbyte_message_actions_hashid,
    tmp.*
from {{ ref('message_actions_ab2') }} tmp
-- message_actions
where 1 = 1

