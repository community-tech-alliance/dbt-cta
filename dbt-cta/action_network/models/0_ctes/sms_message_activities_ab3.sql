{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('sms_message_activities_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'link',
        'links',
        'link_id',
        'user_id',
        'group_id',
        'created_at',
        'updated_at',
        'action_type',
        'recipient_id',
        'mobile_message_id',
        'twilio_message_id',
        'mobile_message_stat_id',
        'mobile_message_field_id',
    ]) }} as _airbyte_sms_message_activities_hashid,
    tmp.*
from {{ ref('sms_message_activities_ab2') }} as tmp
-- sms_message_activities
where 1 = 1
