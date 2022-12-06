{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_day_part_ab1') }}
select
    _airbyte_campaigns_hashid,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(end_hour as {{ dbt_utils.type_bigint() }}) as end_hour,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(start_hour as {{ dbt_utils.type_bigint() }}) as start_hour,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_day_part_ab1') }}
-- day_part at campaigns/day_part
where 1 = 1

