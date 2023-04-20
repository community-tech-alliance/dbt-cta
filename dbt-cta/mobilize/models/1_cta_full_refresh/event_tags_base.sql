-- Final base SQL model
-- depends_on: {{ ref('event_tags_ab3') }}
select
    id,
    tag_id,
    event_id,
    tag__name,
    created_date,
    deleted_date,
    modified_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at,
    _airbyte_event_tags_hashid
from {{ ref('event_tags_ab3') }}
-- event_tags from {{ source("cta", "_airbyte_raw_event_tags" ) }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
