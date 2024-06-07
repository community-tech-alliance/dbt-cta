{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('notification_settings_ab4') }}
select
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    third_parties_emails,
    notificate_third_parties,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_notification_settings_hashid
from {{ ref('notification_settings_ab4') }}
