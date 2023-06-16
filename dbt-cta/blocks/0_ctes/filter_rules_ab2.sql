{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('filter_rules_ab1') }}
select
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(param as {{ dbt_utils.type_string() }}) as param,
    cast(column as {{ dbt_utils.type_string() }}) as column,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(filter_view_id as {{ dbt_utils.type_bigint() }}) as filter_view_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(operator as {{ dbt_utils.type_string() }}) as operator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('filter_rules_ab1') }}
-- filter_rules
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

