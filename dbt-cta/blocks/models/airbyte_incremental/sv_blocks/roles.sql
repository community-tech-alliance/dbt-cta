{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('roles_scd') }}
select
    needs_training,
    admin,
    created_at,
    description,
    abilities,
    depth,
    updated_at,
    parent_id,
    permissions,
    name,
    id,
    lft,
    rgt,
    dashboard_layout_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_roles_hashid
from {{ ref('roles_scd') }}
-- roles from {{ source('sv_blocks', '_airbyte_raw_roles') }}

