SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    created_at,
    id,
    team_id,
    updated_at,
    user_id,
    _unique_row_id
FROM {{ source('cta', 'user_team_base') }}
                        