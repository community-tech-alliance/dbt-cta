{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('check_ins_ab1') }}
select
    cast({{ empty_string_to_null('end_date') }} as {{ type_date() }}) as end_date,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    days_of_the_week,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('check_ins_ab1') }}
-- check_ins
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

