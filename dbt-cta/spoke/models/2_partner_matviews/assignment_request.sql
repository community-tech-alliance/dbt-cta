{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    amount,
    approved_by_user_id,
    created_at,
    id,
    organization_id,
    preferred_team_id,
    status,
    updated_at,
    user_id,
        id
    FROM {{ source('cta', 'assignment_request_base') }}