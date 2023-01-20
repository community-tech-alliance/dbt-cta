{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tag_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(author_id as {{ dbt_utils.type_bigint() }}) as author_id,
    {{ cast_to_boolean('is_system') }} as is_system,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast({{ empty_string_to_null('deleted_at') }} as {{ type_timestamp_without_timezone() }}) as deleted_at,
    cast(text_color as {{ dbt_utils.type_string() }}) as text_color,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(webhook_url as {{ dbt_utils.type_string() }}) as webhook_url,
    {{ cast_to_boolean('is_assignable') }} as is_assignable,
    cast(on_apply_script as {{ dbt_utils.type_string() }}) as on_apply_script,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(background_color as {{ dbt_utils.type_string() }}) as background_color,
    confirmation_steps,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tag_ab1') }}
-- tag
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

