{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('notification_settings_ab3') }}
select
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    third_parties_emails,
    notificate_third_parties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_notification_settings_hashid
from {{ ref('notification_settings_ab3') }}
-- notification_settings from {{ source('cta', '_airbyte_raw_notification_settings') }}
where 1 = 1

