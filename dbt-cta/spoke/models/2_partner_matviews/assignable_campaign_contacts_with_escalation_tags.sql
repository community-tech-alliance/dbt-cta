{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    applied_escalation_tags,
    campaign_id,
    contact_timezone,
    id,
    message_status,
        id
    FROM {{ source('cta', 'assignable_campaign_contacts_with_escalation_tags_base') }}