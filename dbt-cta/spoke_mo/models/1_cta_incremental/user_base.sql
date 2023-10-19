{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    materialized = "incremental",
    incremental_strategy = "merge",
    on_schema_change = "sync_all_columns",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_ab4') }}
select
    terms,
    extra,
    assigned_cell,
    alias,
    last_name,
    created_at,
    id,
    cell,
    auth0_id,
    is_superadmin,
    first_name,
    email,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_hashid
from {{ ref('user_ab4') }}
-- user from {{ source('cta', '_airbyte_raw_user') }}
where 1=1

