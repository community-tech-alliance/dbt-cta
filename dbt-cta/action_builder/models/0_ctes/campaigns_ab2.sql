{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(created_by_id as {{ dbt_utils.type_bigint() }}) as created_by_id,
    cast(target_number as {{ dbt_utils.type_bigint() }}) as target_number,
    cast(default_country as {{ dbt_utils.type_string() }}) as default_country,
    {{ cast_to_boolean('show_custom_ids') }} as show_custom_ids,
    cast(support_user_id as {{ dbt_utils.type_bigint() }}) as support_user_id,
    cast(toplines_settings as {{ dbt_utils.type_string() }}) as toplines_settings,
    cast(default_entity_type_id as {{ dbt_utils.type_bigint() }}) as default_entity_type_id,
    {{ cast_to_boolean('show_electoral_districts') }} as show_electoral_districts,
    {{ cast_to_boolean('allow_organizers_to_export') }} as allow_organizers_to_export,
    cast(restricted_exporting_settings as {{ dbt_utils.type_string() }}) as restricted_exporting_settings,
    {{ cast_to_boolean('activity_stream_as_initial_entity_view') }} as activity_stream_as_initial_entity_view,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_ab1') }}
-- campaigns
where 1 = 1
