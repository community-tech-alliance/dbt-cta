{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    autosend_status,
    id,
    limit_assignment_to_teams,
    organization_id,
    title,
        id
    FROM {{ source('cta', 'assignable_campaigns_base') }}