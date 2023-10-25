{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('reports_export_ab1') }}
select
    cast(user_email as {{ dbt_utils.type_string() }}) as user_email,
    cast(reportable_id as {{ dbt_utils.type_bigint() }}) as reportable_id,
    cast(reportable_voterbase_id as {{ dbt_utils.type_string() }}) as reportable_voterbase_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(reportable_van_id as {{ dbt_utils.type_string() }}) as reportable_van_id,
    cast(user_fullname as {{ dbt_utils.type_string() }}) as user_fullname,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(reportable_type as {{ dbt_utils.type_string() }}) as reportable_type,
    cast(reportable_phone as {{ dbt_utils.type_string() }}) as reportable_phone,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(reportable_email as {{ dbt_utils.type_string() }}) as reportable_email,
    cast(taggings as {{ dbt_utils.type_string() }}) as taggings,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(customizations as {{ dbt_utils.type_string() }}) as customizations,
    cast(reportable_fullname as {{ dbt_utils.type_string() }}) as reportable_fullname,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('reports_export_ab1') }}
-- reports_export
where 1 = 1

