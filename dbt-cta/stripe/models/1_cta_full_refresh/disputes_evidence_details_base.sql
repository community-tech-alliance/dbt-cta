{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('disputes_evidence_details_ab3') }}
select
    _airbyte_disputes_hashid,
    due_by,
    past_due,
    has_evidence,
    submission_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_evidence_details_hashid
from {{ ref('disputes_evidence_details_ab3') }}
-- evidence_details at disputes_base/evidence_details from {{ ref('disputes_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

