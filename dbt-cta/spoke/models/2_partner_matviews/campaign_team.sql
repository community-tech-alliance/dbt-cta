{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    campaign_id,
    created_at,
    id,
    team_id,
    updated_at,
        id
    FROM {{ source('cta', 'campaign_team_base') }}