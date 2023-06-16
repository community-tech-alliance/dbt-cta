{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('activist_code_counts_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(activist_code_id as {{ dbt_utils.type_bigint() }}) as activist_code_id,
    cast(count as {{ dbt_utils.type_bigint() }}) as count,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('datecanvassed') }} as {{ type_date() }}) as datecanvassed,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('activist_code_counts_ab1') }}
-- activist_code_counts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

