SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    created_at,
    id,
    team_id,
    updated_at,
    _unique_row_id
FROM {{ source('cta', 'campaign_team_base') }}
                        