
SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_id,
    created_at,
    id,
    text,
    title,
    updated_at,
    user_id,
    _cta_hashid
FROM {{ source('cta', 'canned_response_base') }}