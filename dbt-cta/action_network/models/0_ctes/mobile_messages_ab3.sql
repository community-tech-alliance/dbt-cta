{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('mobile_messages_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'body',
        'uuid',
        'stats',
        'hidden',
        'status',
        'user_id',
        'group_id',
        'tag_list',
        'media_url',
        'permalink',
        'send_date',
        'timezones',
        'created_at',
        'is_sending',
        'total_sent',
        'updated_at',
        'finish_send',
        'delivered_at',
        'actions_count',
        'first_permalink',
        'administrative_title',
    ]) }} as _airbyte_mobile_messages_hashid,
    tmp.*
from {{ ref('mobile_messages_ab2') }} as tmp
-- mobile_messages
where 1 = 1
