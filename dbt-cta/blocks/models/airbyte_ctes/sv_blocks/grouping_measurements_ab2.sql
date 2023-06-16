{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('grouping_measurements_ab1') }}
select
    cast(measurable_id as {{ dbt_utils.type_bigint() }}) as measurable_id,
    cast(grouping_id as {{ dbt_utils.type_bigint() }}) as grouping_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(position as {{ dbt_utils.type_bigint() }}) as position,
    cast(measurable_type as {{ dbt_utils.type_string() }}) as measurable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('grouping_measurements_ab1') }}
-- grouping_measurements
where 1 = 1

