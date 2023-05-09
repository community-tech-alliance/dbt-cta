{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    created_at,
    id,
    team_id,
    updated_at,
    user_id,
        id
    FROM {{ source('cta', 'user_team_base') }}