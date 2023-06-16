{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    schema = "sv_blocks",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('filter_views_scd') }}
select
    _airbyte_unique_key,
    metadata,
    conjunction,
    updated_at,
    user_id,
    name,
    created_at,
    rules,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filter_views_hashid
from {{ ref('filter_views_scd') }}
-- filter_views from {{ source('sv_blocks', '_airbyte_raw_filter_views') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

