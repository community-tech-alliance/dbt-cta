{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions=partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_queues_hashid',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('queues_ab4') }}
select
    sid,
    uri,
    max_size,
    account_sid,
    current_size,
    date_created,
    date_updated,
    friendly_name,
    subresource_uris,
    average_wait_time,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_queues_hashid
from {{ ref('queues_ab4') }}
-- queues from {{ source('cta', '_airbyte_raw_queues') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

