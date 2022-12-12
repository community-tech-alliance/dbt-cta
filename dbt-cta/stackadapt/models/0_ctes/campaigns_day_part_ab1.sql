{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_vfp_stackadapt_raw_v2",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('campaigns') }}
select
    _airbyte_campaigns_hashid,
    {{ json_extract_scalar('day_part', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('day_part', ['end_hour'], ['end_hour']) }} as end_hour,
    {{ json_extract_scalar('day_part', ['timezone'], ['timezone']) }} as timezone,
    {{ json_extract_scalar('day_part', ['start_hour'], ['start_hour']) }} as start_hour,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('campaigns') }} as table_alias
-- day_part at campaigns/day_part
where 1 = 1
and day_part is not null

