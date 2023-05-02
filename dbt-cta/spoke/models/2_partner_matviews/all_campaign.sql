{{ config(
	auto_refresh = false,
	full_refresh = false
)}}

    SELECT
        _cta_sync_rowid,
    _cta_sync_datetime_utc,
    autosend_limit,
    autosend_limit_max_contact_id,
    autosend_status,
    autosend_user_id,
    created_at,
    creator_id,
    description,
    due_by,
    external_system_id,
    id,
    intro_html,
    is_approved,
    is_archived,
    is_autoassign_enabled,
    is_started,
    is_template,
    landlines_filtered,
    limit_assignment_to_teams,
    logo_image_url,
    messaging_service_sid,
    organization_id,
    primary_color,
    replies_stale_after_minutes,
    texting_hours_end,
    texting_hours_start,
    timezone,
    title,
    updated_at,
    use_dynamic_assignment,
        id
    FROM {{ source('cta', 'all_campaign_base') }}