{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('media_ab2') }}
select
    id,
    {{ adapter.quote('hash') }},
    name,
    type,
    file_name,
    created_at,
    updated_at,
    visibility,
    media_status,
    ad_account_id,
    download_link,
    is_demo_media,
    image_metadata,
    video_metadata,
    file_size_in_bytes,
    duration_in_seconds,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('media_ab2') }}
-- media from {{ source('cta', '_airbyte_raw_media') }}
