{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    assignment_id,
    campaign_contact_id,
    campaign_variable_ids,
    contact_number,
    created_at,
    error_codes,
    id,
    is_from_contact,
    num_media,
    num_segments,
    queued_at,
    script_version_hash,
    send_before,
    send_status,
    sent_at,
    service,
    service_id,
    service_response,
    service_response_at,
    text,
    updated_at,
    user_id,
    user_number,
        id
    FROM {{ source('cta', 'message_base') }}