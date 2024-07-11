{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('log_ab1') }}
select
    cast(from_num as {{ dbt_utils.type_string() }}) as from_num,
    cast(to_num as {{ dbt_utils.type_string() }}) as to_num,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(error_code as {{ dbt_utils.type_bigint() }}) as error_code,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(message_sid as {{ dbt_utils.type_string() }}) as message_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('log_ab1') }}
-- log
where 1 = 1


