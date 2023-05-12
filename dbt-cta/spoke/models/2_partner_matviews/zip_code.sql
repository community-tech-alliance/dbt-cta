{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

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
    _cta_hashid
FROM {{ source('cta', 'zip_code_base') }}