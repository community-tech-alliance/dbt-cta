{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{
    config(
        cluster_by="_airbyte_emitted_at",
        partition_by={
            "field": "_airbyte_emitted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_airbyte_timeslots_hashid",
    )
}}

-- depends_on: {{ source('cta', 'timeslots_base') }}
select
    _airbyte_timeslots_hashid,
    max(id) as id,
    max(end_date) as end_date,
    max(event_id) as event_id,
    max(start_date) as start_date,
    max(created_date) as created_date,
    max(deleted_date) as deleted_date,
    max(max_attendees) as max_attendees,
    max(modified_date) as modified_date,
    max(_airbyte_ab_id) as _airbyte_ab_id,
    max(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ source("cta", "timeslots_base") }}
group by _airbyte_timeslots_hashid
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}
