{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "zip"
) }}
-- Final base SQL model
-- depends_on: {{ ref('zip_code_ab4') }}
select
    zip,
    city,
    latitude,
    timezone_offset,
    state,
    has_dst,
    longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_zip_code_hashid
from {{ ref('zip_code_ab4') }}
-- zip_code from {{ source('cta', '_airbyte_raw_zip_code') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
