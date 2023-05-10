{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    assignment_priority,
    assignment_type,
    author_id,
    background_color,
    created_at,
    description,
    id,
    is_assignment_enabled,
    max_request_count,
    organization_id,
    text_color,
    title,
    updated_at,
    _cta_hashid
FROM {{ source('cta', 'team_base') }}