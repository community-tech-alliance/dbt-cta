{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}

-- depends_on: {{ ref('media_ab3') }}
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
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_media_hashid
from {{ ref('media_ab3') }}
-- media from {{ source('cta', '_airbyte_raw_media') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

