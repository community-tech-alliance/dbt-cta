
SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    autosend_status,
    id,
    limit_assignment_to_teams,
    organization_id,
    title,
    _cta_hashid
FROM {{ source('cta', 'assignable_campaigns_base') }}