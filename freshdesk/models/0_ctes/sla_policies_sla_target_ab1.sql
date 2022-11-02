{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('sla_policies') }}
select
    _airbyte_sla_policies_hashid,
    {{ json_extract('table_alias', 'sla_target', ['priority_1'], ['priority_1']) }} as priority_1,
    {{ json_extract('table_alias', 'sla_target', ['priority_2'], ['priority_2']) }} as priority_2,
    {{ json_extract('table_alias', 'sla_target', ['priority_3'], ['priority_3']) }} as priority_3,
    {{ json_extract('table_alias', 'sla_target', ['priority_4'], ['priority_4']) }} as priority_4,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sla_policies') }} as table_alias
-- sla_target at sla_policies/sla_target
where 1 = 1
and sla_target is not null

