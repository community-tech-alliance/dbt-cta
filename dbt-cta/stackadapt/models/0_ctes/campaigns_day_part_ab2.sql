{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('campaigns_day_part_ab1') }}
select
    _airbyte_campaigns_hashid,
    safe_cast(enabled as boolean) as enabled,
    cast(end_hour as {{ dbt_utils.type_bigint() }}) as end_hour,
    cast(timezone as {{ dbt_utils.type_string() }}) as timezone,
    cast(start_hour as {{ dbt_utils.type_bigint() }}) as start_hour,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns_day_part_ab1') }}
-- day_part at campaigns_base/day_part
where 1 = 1
