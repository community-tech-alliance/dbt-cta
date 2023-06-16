{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('folders_scd') }}
select
    _airbyte_unique_key,
    depth,
    updated_at,
    parent_id,
    name,
    extras,
    created_at,
    id,
    lft,
    rgt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_folders_hashid
from {{ ref('folders_scd') }}
-- folders from {{ source('sv_blocks', '_airbyte_raw_folders') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

