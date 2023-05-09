{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    id,
    organization_id,
    request_status,
    role,
    updated_at,
    user_id,
        id
    FROM {{ source('cta', 'user_organization_base') }}