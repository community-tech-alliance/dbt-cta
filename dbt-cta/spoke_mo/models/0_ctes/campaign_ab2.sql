{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaign_ab1') }}
select
    {{ cast_to_boolean('override_organization_texting_hours') }} as override_organization_texting_hours,
    cast(batch_size as {{ dbt_utils.type_bigint() }}) as batch_size,
    cast(texting_hours_start as {{ dbt_utils.type_bigint() }}) as texting_hours_start,
    cast(logo_image_url as {{ dbt_utils.type_string() }}) as logo_image_url,
    cast({{ empty_string_to_null('due_by') }} as {{ type_timestamp_with_timezone() }}) as due_by,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(texting_hours_end as {{ dbt_utils.type_bigint() }}) as texting_hours_end,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(primary_color as {{ dbt_utils.type_string() }}) as primary_color,
    {{ cast_to_boolean('use_dynamic_assignment') }} as use_dynamic_assignment,
    {{ cast_to_boolean('use_own_messaging_service') }} as use_own_messaging_service,
    cast(features as {{ dbt_utils.type_string() }}) as features,
    {{ cast_to_boolean('is_started') }} as is_started,
    cast(join_token as {{ dbt_utils.type_string() }}) as join_token,
    {{ cast_to_boolean('is_archived') }} as is_archived,
    cast(intro_html as {{ dbt_utils.type_string() }}) as intro_html,
    {{ cast_to_boolean('texting_hours_enforced') }} as texting_hours_enforced,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(creator_id as {{ dbt_utils.type_bigint() }}) as creator_id,
    cast(messageservice_sid as {{ dbt_utils.type_string() }}) as messageservice_sid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(response_window as {{ dbt_utils.type_float() }}) as response_window,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaign_ab1') }}
-- campaign
where 1 = 1


