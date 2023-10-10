{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('applications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'sms_url',
        'voice_url',
        'sms_method',
        'account_sid',
        'api_version',
        'date_created',
        'date_updated',
        'voice_method',
        'friendly_name',
        'status_callback',
        'sms_fallback_url',
        'voice_fallback_url',
        'sms_fallback_method',
        'sms_status_callback',
        'voice_fallback_method',
        'status_callback_method',
        boolean_to_string('voice_caller_id_lookup'),
        'message_status_callback',
        boolean_to_string('public_application_connect_enabled'),
    ]) }} as _airbyte_applications_hashid,
    tmp.*
from {{ ref('applications_ab2') }} as tmp
-- applications
where 1 = 1
