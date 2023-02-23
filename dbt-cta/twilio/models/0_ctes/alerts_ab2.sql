{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('alerts_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(log_level as {{ dbt_utils.type_string() }}) as log_level,
    cast(more_info as {{ dbt_utils.type_string() }}) as more_info,
    cast(alert_text as {{ dbt_utils.type_string() }}) as alert_text,
    cast(error_code as {{ dbt_utils.type_string() }}) as error_code,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(request_url as {{ dbt_utils.type_string() }}) as request_url,
    cast(service_sid as {{ dbt_utils.type_string() }}) as service_sid,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(resource_sid as {{ dbt_utils.type_string() }}) as resource_sid,
    cast({{ empty_string_to_null('date_generated') }} as {{ type_timestamp_with_timezone() }}) as date_generated,
    cast(request_method as {{ dbt_utils.type_string() }}) as request_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('alerts_ab1') }}
-- alerts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

