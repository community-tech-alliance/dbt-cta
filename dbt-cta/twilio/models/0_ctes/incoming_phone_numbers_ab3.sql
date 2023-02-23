{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('incoming_phone_numbers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        boolean_to_string('beta'),
        'origin',
        'status',
        'sms_url',
        'trunk_sid',
        'voice_url',
        'bundle_sid',
        'sms_method',
        'account_sid',
        'address_sid',
        'api_version',
        object_to_string('capabilities'),
        'date_created',
        'date_updated',
        'identity_sid',
        'phone_number',
        'voice_method',
        'friendly_name',
        'status_callback',
        'emergency_status',
        'sms_fallback_url',
        'voice_fallback_url',
        'voice_receive_mode',
        'sms_application_sid',
        'sms_fallback_method',
        'address_requirements',
        'emergency_address_sid',
        'voice_application_sid',
        'voice_fallback_method',
        'status_callback_method',
        boolean_to_string('voice_caller_id_lookup'),
        'emergency_address_status',
    ]) }} as _airbyte_incoming_phone_numbers_hashid,
    tmp.*
from {{ ref('incoming_phone_numbers_ab2') }} tmp
-- incoming_phone_numbers
where 1 = 1

