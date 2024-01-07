{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_scripts_ab3') }}
select
    updated_at,
    organization_id,
    extras,
    created_at,
    id,
    cause_statement,
    created_by_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_phone_banking_scripts_hashid
from {{ ref('phone_banking_scripts_ab3') }}
-- phone_banking_scripts from {{ source('cta', '_airbyte_raw_phone_banking_scripts') }}
