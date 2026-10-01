{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'user_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'summary_user') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    user_id,
    last_open,
    created_at,
    last_click,
    updated_at,
    last_action,
    last_mailed,
    last_donation,
    last_raw_open,
    last_subscribed,
    mailbox_provider,
    last_mailing_action,
    actions_last_30_days,
    actions_last_60_days,
    actions_last_90_days,
    actions_last_180_days,
    actions_last_270_days,
    actions_last_365_days
from {{ source('cta', 'summary_user') }}
