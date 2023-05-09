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
    tag_id,
    tagger_id,
    updated_at,
        campaign_contact_id
    FROM {{ source('cta', 'campaign_contact_tag_base') }}