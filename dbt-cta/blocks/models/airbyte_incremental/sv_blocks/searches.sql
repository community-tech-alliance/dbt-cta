{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('searches_scd') }}
select
    _airbyte_unique_key,
    updated_at,
    query,
    search_params,
    name,
    extras,
    created_at,
    id,
    created_by_user_id,
    current_list,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_searches_hashid
from {{ ref('searches_scd') }}
-- searches from {{ source('sv_blocks', '_airbyte_raw_searches') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

