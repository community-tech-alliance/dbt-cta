{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_team_ab3') }}
select
    id,
    team_id,
    user_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_team_hashid
from {{ ref('user_team_ab3') }}
-- user_team from {{ source('public', '_airbyte_raw_user_team') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

