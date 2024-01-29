{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('dependent_phone_numbers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'sid',
        'uri',
        'sms_url',
        'trunk_sid',
        'voice_url',
        'sms_method',
        'account_sid',
        'api_version',
        object_to_string('capabilities'),
        'date_created',
        'date_updated',
        'phone_number',
        'voice_method',
        'friendly_name',
        'status_callback',
        'emergency_status',
        'sms_fallback_url',
        'voice_fallback_url',
        'sms_application_sid',
        'sms_fallback_method',
        'address_requirements',
        'emergency_address_sid',
        'voice_application_sid',
        'voice_fallback_method',
        'status_callback_method',
        boolean_to_string('voice_caller_id_lookup'),
    ]) }} as _airbyte_dependent_phone_numbers_hashid,
    tmp.*
from {{ ref('dependent_phone_numbers_ab2') }} as tmp
-- dependent_phone_numbers
where 1 = 1
