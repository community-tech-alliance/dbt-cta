{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_campaign_uploads_ab3') }}
select
    id,
    {{ adapter.quote('rows') }},
    failure,
    user_id,
    created_at,
    updated_at,
    upload_type,
    fail_message,
    csv_file_name,
    csv_file_size,
    csv_content_type,
    event_campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_campaign_uploads_hashid
from {{ ref('event_campaign_uploads_ab3') }}
-- event_campaign_uploads from {{ source('cta', '_airbyte_raw_event_campaign_uploads') }}
where 1 = 1

