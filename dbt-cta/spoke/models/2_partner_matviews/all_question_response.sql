{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    campaign_contact_id,
    created_at,
    id,
    interaction_step_id,
    is_deleted,
    updated_at,
    value,
        id
    FROM {{ source('cta', 'all_question_response_base') }}