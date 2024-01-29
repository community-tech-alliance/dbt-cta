{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sms_messages_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        adapter.quote('to'),
        adapter.quote('from'),
        'read',
        'flagged',
        'message',
        'user_id',
        'group_id',
        'created_at',
        'updated_at',
        'message_type',
        'twilio_message_id',
    ]) }} as _airbyte_sms_messages_hashid,
    tmp.*
from {{ ref('sms_messages_ab2') }} as tmp
-- sms_messages
where 1 = 1
