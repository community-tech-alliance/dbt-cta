{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('shifts_wage_ab1') }}
select
    _airbyte_shifts_hashid,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(hourly_rate as {{ type_json() }}) as hourly_rate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts_wage_ab1') }}
-- wage at shifts/wage
where 1 = 1

