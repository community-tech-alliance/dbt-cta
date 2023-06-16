{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('quality_control_comments_scd') }}
select
    flag_id,
    updated_at,
    created_at,
    id,
    body,
    author_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_quality_control_comments_hashid
from {{ ref('quality_control_comments_scd') }}
-- quality_control_comments from {{ source('sv_blocks', '_airbyte_raw_quality_control_comments') }}

