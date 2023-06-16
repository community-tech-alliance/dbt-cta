{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('reports_scd') }}
select
    _airbyte_unique_key,
    date,
    collection_id,
    updated_at,
    user_id,
    qualitative_metrics,
    quantitative_metrics,
    created_at,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reports_hashid
from {{ ref('reports_scd') }}
-- reports from {{ source('sv_blocks', '_airbyte_raw_reports') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

