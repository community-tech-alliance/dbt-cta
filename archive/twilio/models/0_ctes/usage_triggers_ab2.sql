{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('usage_triggers_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(recurring as {{ dbt_utils.type_string() }}) as recurring,
    cast({{ empty_string_to_null('date_fired') }} as {{ type_timestamp_with_timezone() }}) as date_fired,
    cast(trigger_by as {{ dbt_utils.type_string() }}) as trigger_by,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(callback_url as {{ dbt_utils.type_string() }}) as callback_url,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(current_value as {{ dbt_utils.type_float() }}) as current_value,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(trigger_value as {{ dbt_utils.type_float() }}) as trigger_value,
    cast(usage_category as {{ dbt_utils.type_string() }}) as usage_category,
    cast(callback_method as {{ dbt_utils.type_string() }}) as callback_method,
    cast(usage_record_uri as {{ dbt_utils.type_string() }}) as usage_record_uri,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('usage_triggers_ab1') }}
-- usage_triggers
where 1 = 1
