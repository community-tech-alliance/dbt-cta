{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activity_scripts_export_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(script_type as {{ dbt_utils.type_string() }}) as script_type,
    cast(media_url as {{ dbt_utils.type_string() }}) as media_url,
    cast(script as {{ dbt_utils.type_string() }}) as script,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(next_scripts as {{ dbt_utils.type_string() }}) as next_scripts,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activity_scripts_export_ab1') }}
-- activity_scripts_export
where 1 = 1

