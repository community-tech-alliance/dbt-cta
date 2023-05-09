{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    created_at,
    hash,
    id,
    is_valid,
    payload,
    updated_at,
        id
    FROM {{ source('cta', 'invite_base') }}