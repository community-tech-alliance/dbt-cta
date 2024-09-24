{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('opt_out_ab1') }}
select
    cast(reason_code as {{ dbt_utils.type_string() }}) as reason_code,
    cast(assignment_id as {{ dbt_utils.type_bigint() }}) as assignment_id,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_with_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(cell as {{ dbt_utils.type_string() }}) as cell,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('opt_out_ab1') }}
-- opt_out
where 1 = 1
