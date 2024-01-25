{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace
) }}
-- Final base SQL model
-- depends_on: {{ ref('native_ads_input_data_audio_creatives_ab3') }}
select
    _airbyte_input_data_hashid,
    width,
    height,
    s3_url,
    bitrate,
    duration,
    file_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_audio_creatives_hashid
from {{ ref('native_ads_input_data_audio_creatives_ab3') }}
-- audio_creatives at native_ads/input_data/audio_creatives from {{ ref('native_ads_input_data_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

