{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_ab1') }}
select
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(location_id as {{ dbt_utils.type_bigint() }}) as location_id,
    cast(event_type_id as {{ dbt_utils.type_bigint() }}) as event_type_id,
    {{ cast_to_boolean('public') }} as public,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(public_page_header_data as {{ dbt_utils.type_string() }}) as public_page_header_data,
    cast(public_page_header_map_data as {{ dbt_utils.type_string() }}) as public_page_header_map_data,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(invited_count as {{ dbt_utils.type_bigint() }}) as invited_count,
    cast(no_show_count as {{ dbt_utils.type_bigint() }}) as no_show_count,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_without_timezone() }}) as end_time,
    cast(public_settings as {{ dbt_utils.type_string() }}) as public_settings,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_without_timezone() }}) as start_time,
    cast(first_occurrence_id as {{ dbt_utils.type_bigint() }}) as first_occurrence_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(walk_in_count as {{ dbt_utils.type_bigint() }}) as walk_in_count,
    cast(attended_count as {{ dbt_utils.type_bigint() }}) as attended_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_ab1') }}
-- events
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

