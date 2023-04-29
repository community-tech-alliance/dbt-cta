SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    city,
    has_dst,
    latitude,
    longitude,
    state,
    timezone_offset,
    zip,
    _unique_row_id
FROM {{ source('cta', 'zip_code_base') }}
                        