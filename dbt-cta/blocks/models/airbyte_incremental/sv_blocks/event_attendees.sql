{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_attendees_scd') }}
select
    needs,
    marked_no_show_at,
    marked_walk_in_at,
    event_id,
    updated_at,
    inviter_id,
    creator_id,
    created_at,
    id,
    marked_attended_at,
    status,
    person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_attendees_hashid
from {{ ref('event_attendees_scd') }}
-- event_attendees from {{ source('sv_blocks', '_airbyte_raw_event_attendees') }}

