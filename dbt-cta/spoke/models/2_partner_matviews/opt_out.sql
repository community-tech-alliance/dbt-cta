{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    assignment_id,
    cell,
    created_at,
    id,
    organization_id,
    reason_code,
    updated_at,
        id
    FROM {{ source('cta', 'opt_out_base') }}