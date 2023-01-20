{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('troll_trigger_ab1') }}
select
    cast(mode as {{ dbt_utils.type_string() }}) as mode,
    cast(token as {{ dbt_utils.type_string() }}) as token,
    cast(organization_id as {{ dbt_utils.type_bigint() }}) as organization_id,
    cast(compiled_tsquery as {{ dbt_utils.type_string() }}) as compiled_tsquery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('troll_trigger_ab1') }}
-- troll_trigger
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

