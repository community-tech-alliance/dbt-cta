
SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
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
    _cta_hashid
FROM {{ source('cta', 'interaction_step_base') }}