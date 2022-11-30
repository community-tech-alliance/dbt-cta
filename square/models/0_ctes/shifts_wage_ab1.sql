{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('shifts') }}
select
    _airbyte_shifts_hashid,
    {{ json_extract_scalar('wage', ['title'], ['title']) }} as title,
    {{ json_extract('table_alias', 'wage', ['hourly_rate'], ['hourly_rate']) }} as hourly_rate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('shifts') }} as table_alias
-- wage at shifts/wage
where 1 = 1
and wage is not null

