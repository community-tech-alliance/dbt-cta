SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_contact_id,
    created_at,
    tag_id,
    tagger_id,
    updated_at,
    _unique_row_id
FROM {{ source('cta', 'campaign_contact_tag_base') }}
                        