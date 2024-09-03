{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_activity_performances_export_ab1') }}
select
    cast({{ empty_string_to_null('performed_at') }} as {{ type_timestamp_without_timezone() }}) as performed_at,
    cast(user_email as {{ dbt_utils.type_string() }}) as user_email,
    cast(user_last_name as {{ dbt_utils.type_string() }}) as user_last_name,
    cast(user_fullname as {{ dbt_utils.type_string() }}) as user_fullname,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast({{ empty_string_to_null('exported_at') }} as {{ type_date() }}) as exported_at,
    cast(user_first_name as {{ dbt_utils.type_string() }}) as user_first_name,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(activity_id as {{ dbt_utils.type_bigint() }}) as activity_id,
    cast(user_phone as {{ dbt_utils.type_string() }}) as user_phone,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(activity_title as {{ dbt_utils.type_string() }}) as activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_activity_performances_export_ab1') }}
-- user_activity_performances_export
where 1 = 1

