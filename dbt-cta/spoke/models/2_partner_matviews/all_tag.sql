{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

SELECT
    _cta_sync_rowid,
    _cta_sync_datetime_utc,
    author_id,
    background_color,
    confirmation_steps,
    created_at,
    deleted_at,
    description,
    id,
    is_assignable,
    is_system,
    on_apply_script,
    organization_id,
    text_color,
    title,
    updated_at,
    webhook_url,
    _cta_hashid
FROM {{ source('cta', 'all_tag_base') }}