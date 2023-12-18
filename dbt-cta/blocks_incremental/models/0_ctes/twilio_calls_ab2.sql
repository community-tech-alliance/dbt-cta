{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('twilio_calls_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(remote_id as {{ dbt_utils.type_string() }}) as remote_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(scan_id as {{ dbt_utils.type_bigint() }}) as scan_id,
    cast({{ empty_string_to_null('disconnected_at') }} as {{ type_timestamp_without_timezone() }}) as disconnected_at,
    cast(duration_in_seconds as {{ dbt_utils.type_bigint() }}) as duration_in_seconds,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('twilio_calls_ab1') }}
-- twilio_calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

