{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    _cta_hashid,
    autosending_mps,
    created_at,
    default_texting_tz,
    deleted_at,
    deleted_by,
    features,
    id,
    monthly_message_limit,
    name,
    texting_hours_end,
    texting_hours_enforced,
    texting_hours_start,
    updated_at,
    uuid,
        id
    FROM {{ source('cta', 'organization_base') }}