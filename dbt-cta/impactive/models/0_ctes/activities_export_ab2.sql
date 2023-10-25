{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activities_export_ab1') }}
select
    cast(performs as {{ dbt_utils.type_bigint() }}) as performs,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(completions as {{ dbt_utils.type_bigint() }}) as completions,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(started as {{ dbt_utils.type_bigint() }}) as started,
    cast(folder_name as {{ dbt_utils.type_string() }}) as folder_name,
    cast(impressions as {{ dbt_utils.type_bigint() }}) as impressions,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(seen as {{ dbt_utils.type_bigint() }}) as seen,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(privacy_setting as {{ dbt_utils.type_string() }}) as privacy_setting,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(contact_list_id as {{ dbt_utils.type_bigint() }}) as contact_list_id,
    cast(contact_list_name as {{ dbt_utils.type_string() }}) as contact_list_name,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(clicks as {{ dbt_utils.type_bigint() }}) as clicks,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(aasm_state as {{ dbt_utils.type_string() }}) as aasm_state,
    cast(folder_id as {{ dbt_utils.type_bigint() }}) as folder_id,
    cast({{ empty_string_to_null('published_at') }} as {{ type_timestamp_without_timezone() }}) as published_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activities_export_ab1') }}
-- activities_export
where 1 = 1

