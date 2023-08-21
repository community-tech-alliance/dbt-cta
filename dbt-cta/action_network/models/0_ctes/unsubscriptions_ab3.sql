{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('unsubscriptions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'reason',
        'user_id',
        'email_id',
        'group_id',
        'new_user',
        'processed',
        'created_at',
        'subject_id',
        'updated_at',
        'source_code',
        'http_referer',
        'custom_fields',
        'subscriber_id',
        'source_action_id',
        'source_action_type',
    ]) }} as _airbyte_unsubscriptions_hashid,
    tmp.*
from {{ ref('unsubscriptions_ab2') }} as tmp
-- unsubscriptions
where 1 = 1
