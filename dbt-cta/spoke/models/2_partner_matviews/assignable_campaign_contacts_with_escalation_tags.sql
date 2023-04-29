SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    applied_escalation_tags,
    campaign_id,
    contact_timezone,
    id,
    message_status,
    _unique_row_id
FROM {{ source('cta', 'assignable_campaign_contacts_with_escalation_tags_base') }}
                        