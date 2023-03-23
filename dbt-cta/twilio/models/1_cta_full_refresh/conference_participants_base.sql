{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    partitions=partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('conference_participants_ab3') }}
select
    uri,
    hold,
    label,
    muted,
    status,
    call_sid,
    coaching,
    account_sid,
    date_created,
    date_updated,
    conference_sid,
    call_sid_to_coach,
    end_conference_on_exit,
    start_conference_on_enter,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_conference_participants_hashid
from {{ ref('conference_participants_ab3') }}
-- conference_participants from {{ source('cta', '_airbyte_raw_conference_participants') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

