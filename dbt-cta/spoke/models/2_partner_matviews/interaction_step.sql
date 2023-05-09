{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    answer_actions,
    answer_option,
    campaign_id,
    created_at,
    id,
    is_deleted,
    parent_interaction_id,
    question,
    script_options,
    updated_at,
        id
    FROM {{ source('cta', 'interaction_step_base') }}