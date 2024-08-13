{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('messages_ab1') }}
select
    cast({{ adapter.quote('to') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('to') }},
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ empty_string_to_null('date_sent') }} as {{ type_timestamp_with_timezone() }}) as date_sent,
    cast(direction as {{ dbt_utils.type_string() }}) as direction,
    cast(num_media as {{ dbt_utils.type_bigint() }}) as num_media,
    cast(error_code as {{ dbt_utils.type_string() }}) as error_code,
    cast(price_unit as {{ dbt_utils.type_string() }}) as price_unit,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(num_segments as {{ dbt_utils.type_bigint() }}) as num_segments,
    cast(error_message as {{ dbt_utils.type_string() }}) as error_message,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    cast(messaging_service_sid as {{ dbt_utils.type_string() }}) as messaging_service_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('messages_ab1') }}
-- messages
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

