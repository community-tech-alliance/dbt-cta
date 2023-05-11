{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    campaign_contact_id,
    created_at,
    tag_id,
    tagger_id,
    updated_at,
    _cta_hashid
FROM {{ source('cta', 'campaign_contact_tag_base') }}