{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies') }}
select
    _airbyte_sla_policies_hashid,
    {{ json_extract('table_alias', 'escalation', ['response'], ['response']) }} as response,
    {{ json_extract('table_alias', 'escalation', ['resolution'], ['resolution']) }} as resolution,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies') }} as table_alias
-- escalation at sla_policies/escalation
where 1 = 1
and escalation is not null

