SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    contact_timezone,
    id,
    message_status,
    texting_hours_end,
    _unique_row_id
FROM {{ source('cta', 'assignable_campaign_contacts_base') }}
                        