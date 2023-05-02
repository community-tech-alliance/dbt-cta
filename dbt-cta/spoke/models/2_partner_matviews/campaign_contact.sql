{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    archived,
    assignment_id,
    campaign_id,
    cell,
    created_at,
    custom_fields,
    external_id,
    first_name,
    first_name_8,
    id,
    is_opted_out,
    last_name,
    message_status,
    timezone,
    updated_at,
    zip,
        id
    FROM {{ source('cta', 'campaign_contact_base') }}