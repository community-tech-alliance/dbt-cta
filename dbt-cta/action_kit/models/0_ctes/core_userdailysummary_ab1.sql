{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_userdailysummary') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    created_at,
    updated_at,
    avg_last_open,
    avg_last_click,
    avg_last_mailed,
    avg_last_donation,
    avg_last_mailing_action,
    avg_scorepool_userscore,
    avg_actions_last_90_days
from {{ source('cta', 'core_userdailysummary') }}
