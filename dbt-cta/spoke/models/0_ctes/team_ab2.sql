{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(author_id as {{ dbt_utils.type_bigint() }}) as author_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(text_color as {{ dbt_utils.type_string() }}) as text_color,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_with_timezone() }}) as updated_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(assignment_type as {{ dbt_utils.type_string() }}) as assignment_type,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(background_color as {{ dbt_utils.type_string() }}) as background_color,
    cast(max_request_count as {{ dbt_utils.type_bigint() }}) as max_request_count,
    cast(assignment_priority as {{ dbt_utils.type_bigint() }}) as assignment_priority,
    {{ cast_to_boolean('is_assignment_enabled') }} as is_assignment_enabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_ab1') }}
-- team
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

