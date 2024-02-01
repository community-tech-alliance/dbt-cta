{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_contact_id,
    created_at,
    id,
    interaction_step_id,
    is_deleted,
    updated_at,
    value,
    _cta_hashid
FROM {{ source('cta', 'question_response_base') }}