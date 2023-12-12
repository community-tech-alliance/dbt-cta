{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('tenants_ab3') }}
select
    contact_phone,
    logo_data,
    created_at,
    leaderboard_metrics,
    logo_old,
    contact_email,
    updated_at,
    shift_times,
    name,
    options,
    subdomain,
    contact_last_name,
    id,
    contact_first_name,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_tenants_hashid
from {{ ref('tenants_ab3') }}
