{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('recordings_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(call_sid as {{ dbt_utils.type_string() }}) as call_sid,
    cast(channels as {{ dbt_utils.type_bigint() }}) as channels,
    cast(duration as {{ dbt_utils.type_bigint() }}) as duration,
    cast(media_url as {{ dbt_utils.type_string() }}) as media_url,
    cast(error_code as {{ dbt_utils.type_bigint() }}) as error_code,
    cast(price_unit as {{ dbt_utils.type_string() }}) as price_unit,
    cast({{ empty_string_to_null('start_time') }} as {{ type_timestamp_with_timezone() }}) as start_time,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(conference_sid as {{ dbt_utils.type_string() }}) as conference_sid,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    cast(encryption_details as {{ type_json() }}) as encryption_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('recordings_ab1') }}
-- recordings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

