{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('all_campaign_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast({{ empty_string_to_null('due_by') }} as {{ type_timestamp_with_timezone() }}) as due_by,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast(intro_html as {{ dbt_utils.type_string() }}) as intro_html,
    {{ cast_to_boolean('is_started') }} as is_started,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    {{ cast_to_boolean('is_approved') }} as is_approved,
    {{ cast_to_boolean('is_archived') }} as is_archived,
    {{ cast_to_boolean('is_template') }} as is_template,
    cast(primary_color as {{ dbt_utils.type_string() }}) as primary_color,
    cast(autosend_limit as {{ dbt_utils.type_bigint() }}) as autosend_limit,
    cast(logo_image_url as {{ dbt_utils.type_string() }}) as logo_image_url,
    cast(autosend_status as {{ dbt_utils.type_string() }}) as autosend_status,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(autosend_user_id as {{ dbt_utils.type_bigint() }}) as autosend_user_id,
    cast(texting_hours_end as {{ dbt_utils.type_bigint() }}) as texting_hours_end,
    cast(external_system_id as {{ dbt_utils.type_string() }}) as external_system_id,
    {{ cast_to_boolean('landlines_filtered') }} as landlines_filtered,
    cast(texting_hours_start as {{ dbt_utils.type_bigint() }}) as texting_hours_start,
    {{ cast_to_boolean('is_autoassign_enabled') }} as is_autoassign_enabled,
    cast(messaging_service_sid as {{ dbt_utils.type_string() }}) as messaging_service_sid,
    {{ cast_to_boolean('use_dynamic_assignment') }} as use_dynamic_assignment,
    {{ cast_to_boolean('limit_assignment_to_teams') }} as limit_assignment_to_teams,
    cast(replies_stale_after_minutes as {{ dbt_utils.type_bigint() }}) as replies_stale_after_minutes,
    cast(autosend_limit_max_contact_id as {{ dbt_utils.type_bigint() }}) as autosend_limit_max_contact_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('all_campaign_ab1') }}
-- all_campaign
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

