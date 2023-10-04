{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_ab3') }}
select
    override_organization_texting_hours,
    batch_size,
    texting_hours_start,
    logo_image_url,
    due_by,
    timezone,
    created_at,
    description,
    texting_hours_end,
    title,
    primary_color,
    use_dynamic_assignment,
    use_own_messaging_service,
    features,
    is_started,
    join_token,
    is_archived,
    intro_html,
    texting_hours_enforced,
    organization_id,
    creator_id,
    messageservice_sid,
    id,
    response_window,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_hashid
from {{ ref('campaign_ab3') }}
-- campaign from {{ source('cta', '_airbyte_raw_campaign') }}
where 1=1

