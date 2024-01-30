{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('admin_users_ab4') }}
select
    session,
    id,
    email,
    encrypted_password,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_admin_users_hashid
from {{ ref('admin_users_ab4') }}
-- admin_users from {{ source('cta', '_airbyte_raw_admin_users') }}
