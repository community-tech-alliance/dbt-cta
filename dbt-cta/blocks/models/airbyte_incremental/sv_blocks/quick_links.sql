{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quick_links_scd') }}
select
    bg_color,
    size,
    updated_at,
    icon,
    link,
    created_at,
    id,
    label,
    text_color,
    block_id,
    target,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quick_links_hashid
from {{ ref('quick_links_scd') }}
-- quick_links from {{ source('sv_blocks', '_airbyte_raw_quick_links') }}

