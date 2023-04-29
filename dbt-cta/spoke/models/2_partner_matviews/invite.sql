SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    created_at,
    hash,
    id,
    is_valid,
    payload,
    updated_at,
    _unique_row_id
FROM {{ source('cta', 'invite_base') }}
                        