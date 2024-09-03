{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('calls_ab1') }}
select
    cast({{ adapter.quote('to') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('to') }},
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(duration as {{ dbt_utils.type_bigint() }}) as duration,
    cast({{ empty_string_to_null('end_time') }} as {{ type_timestamp_with_timezone() }}) as end_time,
    cast(direction as {{ dbt_utils.type_string() }}) as direction,
    cast(group_sid as {{ dbt_utils.type_string() }}) as group_sid,
    cast(trunk_sid as {{ dbt_utils.type_string() }}) as trunk_sid,
    cast(annotation as {{ dbt_utils.type_string() }}) as annotation,
    cast(price_unit as {{ dbt_utils.type_string() }}) as price_unit,
    cast(queue_time as {{ dbt_utils.type_bigint() }}) as queue_time,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_with_timezone() }}) as start_time,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(answered_by as {{ dbt_utils.type_string() }}) as answered_by,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(caller_name as {{ dbt_utils.type_string() }}) as caller_name,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(to_formatted as {{ dbt_utils.type_string() }}) as to_formatted,
    cast(forwarded_from as {{ dbt_utils.type_string() }}) as forwarded_from,
    cast(from_formatted as {{ dbt_utils.type_string() }}) as from_formatted,
    cast(parent_call_sid as {{ dbt_utils.type_string() }}) as parent_call_sid,
    cast(phone_number_sid as {{ dbt_utils.type_string() }}) as phone_number_sid,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('calls_ab1') }}
-- calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

