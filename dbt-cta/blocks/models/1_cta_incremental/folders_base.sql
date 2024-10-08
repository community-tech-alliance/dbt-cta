{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('folders_ab3') }}
select
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
from {{ ref('folders_ab3') }}
-- folders from {{ source('cta', '_airbyte_raw_folders') }}
