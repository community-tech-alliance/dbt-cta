{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    campaign_id,
    created_at,
    id,
    max_contacts,
    updated_at,
    user_id,
        id
    FROM {{ source('cta', 'assignment_base') }}