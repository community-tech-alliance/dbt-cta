SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    id,
    organization_id,
    request_status,
    role,
    updated_at,
    user_id,
    _unique_row_id
FROM {{ source('cta', 'user_organization_base') }}
                        