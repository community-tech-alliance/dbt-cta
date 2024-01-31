{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    contact_timezone,
    id,
    message_status,
    texting_hours_end,
    _cta_hashid
FROM {{ source('cta', 'assignable_campaign_contacts_base') }}