{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('imports_ab1') }}
select
    cast(mapping as {{ dbt_utils.type_string() }}) as mapping,
    cast(list_id as {{ dbt_utils.type_bigint() }}) as list_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    {{ cast_to_boolean('for_phone_bank') }} as for_phone_bank,
    cast(stored_spreadsheet_data as {{ dbt_utils.type_string() }}) as stored_spreadsheet_data,
    cast(original_spreadsheet_data as {{ dbt_utils.type_string() }}) as original_spreadsheet_data,
    cast(record_type as {{ dbt_utils.type_string() }}) as record_type,
    cast(imported_rows_count as {{ dbt_utils.type_bigint() }}) as imported_rows_count,
    cast(mappings as {{ dbt_utils.type_string() }}) as mappings,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(worker_jid as {{ dbt_utils.type_string() }}) as worker_jid,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('imports_ab1') }}
-- imports
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

