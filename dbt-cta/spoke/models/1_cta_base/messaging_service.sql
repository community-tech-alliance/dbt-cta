{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('messaging_service_ab3') }}
select
    name,
    active,
    is_default,
    updated_at,
    account_sid,
    service_type,
    organization_id,
    encrypted_auth_token,
    messaging_service_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_messaging_service_hashid
from {{ ref('messaging_service_ab3') }}
-- messaging_service from {{ source('public', '_airbyte_raw_messaging_service') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

