{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    created_at,
    id,
    max_contacts,
    updated_at,
    user_id,
    _cta_hashid
FROM {{ source('cta', 'assignment_base') }}