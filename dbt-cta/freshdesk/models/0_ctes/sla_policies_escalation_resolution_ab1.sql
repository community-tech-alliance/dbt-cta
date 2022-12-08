{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies_escalation') }}
select
    _airbyte_escalation_hashid,
    {{ json_extract('table_alias', 'resolution', ['level1'], ['level1']) }} as level1,
    {{ json_extract('table_alias', 'resolution', ['level2'], ['level2']) }} as level2,
    {{ json_extract('table_alias', 'resolution', ['level3'], ['level3']) }} as level3,
    {{ json_extract('table_alias', 'resolution', ['level4'], ['level4']) }} as level4,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies_escalation') }} as table_alias
-- resolution at sla_policies/escalation/resolution
where 1 = 1
and resolution is not null

