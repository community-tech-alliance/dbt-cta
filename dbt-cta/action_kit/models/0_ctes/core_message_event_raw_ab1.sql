{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = ['id', 'created_at']
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_message_event_raw') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    user_id,
    action_id,
    reason_id,
    timestamp,
    created_at,
    event_type,
    mailing_id,
    bounce_class,
    email_domain,
    ext_event_id,
    enhanced_status,
    smtp_error_code,
    mailbox_provider
from {{ source('cta', 'core_message_event_raw') }}
