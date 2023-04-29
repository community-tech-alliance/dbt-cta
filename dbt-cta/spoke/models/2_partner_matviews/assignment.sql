SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    created_at,
    id,
    max_contacts,
    updated_at,
    user_id,
    _unique_row_id
FROM {{ source('cta', 'assignment_base') }}
                        