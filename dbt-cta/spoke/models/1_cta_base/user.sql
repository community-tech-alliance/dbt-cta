{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_ab3') }}
select
    id,
    cell,
    email,
    terms,
    auth0_id,
    last_name,
    created_at,
    first_name,
    updated_at,
    is_suspended,
    assigned_cell,
    is_superadmin,
    notification_frequency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_hashid
from {{ ref('user_ab3') }}
-- user from {{ source('public', '_airbyte_raw_user') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

