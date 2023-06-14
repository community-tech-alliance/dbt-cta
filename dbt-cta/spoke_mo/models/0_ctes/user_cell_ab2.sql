{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_cell_ab1') }}
select
    {{ cast_to_boolean('is_primary') }} as is_primary,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(cell as {{ dbt_utils.type_string() }}) as cell,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_cell_ab1') }}
-- user_cell
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

