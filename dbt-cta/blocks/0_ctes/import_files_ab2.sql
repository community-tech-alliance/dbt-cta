{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('import_files_ab1') }}
select
    cast(tenant_id as {{ dbt_utils.type_bigint() }}) as tenant_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(file_name_data as {{ dbt_utils.type_string() }}) as file_name_data,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(encoding as {{ dbt_utils.type_string() }}) as encoding,
    cast(file_size as {{ dbt_utils.type_bigint() }}) as file_size,
    cast(row_count as {{ dbt_utils.type_bigint() }}) as row_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('import_files_ab1') }}
-- import_files
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

