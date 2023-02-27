{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('transcriptions_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(price as {{ dbt_utils.type_float() }}) as price,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(duration as {{ dbt_utils.type_bigint() }}) as duration,
    cast(price_unit as {{ dbt_utils.type_string() }}) as price_unit,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(recording_sid as {{ dbt_utils.type_string() }}) as recording_sid,
    cast(transcription_text as {{ dbt_utils.type_string() }}) as transcription_text,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('transcriptions_ab1') }}
-- transcriptions
where 1 = 1

