{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('votes_scd') }}
select
    _airbyte_unique_key,
    metric_id,
    vote_weight,
    updated_at,
    user_id,
    vote_flag,
    report_id,
    created_at,
    id,
    vote_scope,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_votes_hashid
from {{ ref('votes_scd') }}
-- votes from {{ source('sv_blocks', '_airbyte_raw_votes') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

