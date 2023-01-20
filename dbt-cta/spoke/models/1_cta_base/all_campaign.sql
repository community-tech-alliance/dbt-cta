{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('all_campaign_ab3') }}
select
    id,
    title,
    due_by,
    timezone,
    created_at,
    creator_id,
    intro_html,
    is_started,
    updated_at,
    description,
    is_approved,
    is_archived,
    is_template,
    primary_color,
    autosend_limit,
    logo_image_url,
    autosend_status,
    organization_id,
    autosend_user_id,
    texting_hours_end,
    external_system_id,
    landlines_filtered,
    texting_hours_start,
    is_autoassign_enabled,
    messaging_service_sid,
    use_dynamic_assignment,
    limit_assignment_to_teams,
    replies_stale_after_minutes,
    autosend_limit_max_contact_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_all_campaign_hashid
from {{ ref('all_campaign_ab3') }}
-- all_campaign from {{ source('public', '_airbyte_raw_all_campaign') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

