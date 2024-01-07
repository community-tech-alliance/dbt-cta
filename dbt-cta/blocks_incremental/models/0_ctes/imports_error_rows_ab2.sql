{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('imports_error_rows_ab1') }}
select
    cast(errors_triggered as {{ dbt_utils.type_string() }}) as errors_triggered,
    cast(import_id as {{ dbt_utils.type_bigint() }}) as import_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(row_data as {{ dbt_utils.type_string() }}) as row_data,
    {{ cast_to_boolean('duplicate_found') }} as duplicate_found,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('imports_error_rows_ab1') }}
-- imports_error_rows
where 1 = 1
