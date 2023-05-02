{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    created_at,
    id,
    team_id,
    updated_at,
        id
    FROM {{ source('cta', 'campaign_team_base') }}