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
    _unique_row_id
FROM {{ source('cta', 'all_question_response_base') }}
                        