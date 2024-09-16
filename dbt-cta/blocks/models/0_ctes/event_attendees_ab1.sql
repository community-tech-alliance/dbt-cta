{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_event_attendees') }}
select
    {{ json_extract_scalar('_airbyte_data', ['needs'], ['needs']) }} as needs,
    {{ json_extract_scalar('_airbyte_data', ['marked_no_show_at'], ['marked_no_show_at']) }} as marked_no_show_at,
    {{ json_extract_scalar('_airbyte_data', ['marked_walk_in_at'], ['marked_walk_in_at']) }} as marked_walk_in_at,
    {{ json_extract_scalar('_airbyte_data', ['event_id'], ['event_id']) }} as event_id,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['inviter_id'], ['inviter_id']) }} as inviter_id,
    {{ json_extract_scalar('_airbyte_data', ['creator_id'], ['creator_id']) }} as creator_id,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['marked_attended_at'], ['marked_attended_at']) }} as marked_attended_at,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['person_id'], ['person_id']) }} as person_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_event_attendees') }}
-- event_attendees
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

