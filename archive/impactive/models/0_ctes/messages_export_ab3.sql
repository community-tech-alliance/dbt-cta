{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('messages_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sender_van_id',
        'receiver_selected_voterbase_id',
        'receiver_id',
        'created_at',
        'sender_name',
        'body',
        'sender_selected_voterbase_id',
        'sender_id',
        'receiver_type',
        'aasm_message',
        'updated_at',
        'activity_type',
        'activity_id',
        'receiver_name',
        'activity_published_at',
        'activity_script_id',
        'id',
        'aasm_state',
        'receiver_raw',
        'twilio_segments',
        'campaign_id',
        'activity_title',
        'sender_raw',
        'sender_type',
        'twilio_status',
        'message_type',
        'script_name',
        'exported_at',
        'sent_at',
        'received_at',
        'error_code',
        'script_type',
        'receiver_van_id',
    ]) }} as _airbyte_messages_export_hashid,
    tmp.*
from {{ ref('messages_export_ab2') }} tmp
-- messages_export
where 1 = 1

