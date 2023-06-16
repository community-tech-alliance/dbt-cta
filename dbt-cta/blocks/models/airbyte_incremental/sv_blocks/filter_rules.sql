{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('filter_rules_scd') }}
select
    _airbyte_unique_key,
    updated_at,
    param,
    column,
    created_at,
    filter_view_id,
    id,
    operator,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filter_rules_hashid
from {{ ref('filter_rules_scd') }}
-- filter_rules from {{ source('sv_blocks', '_airbyte_raw_filter_rules') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

