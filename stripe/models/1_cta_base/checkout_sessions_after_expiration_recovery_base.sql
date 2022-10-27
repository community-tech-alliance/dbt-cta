{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_after_expiration_recovery_ab3') }}
select
    _airbyte_after_expiration_hashid,
    url,
    enabled,
    expires_at,
    allow_promotion_codes,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_recovery_hashid
from {{ ref('checkout_sessions_after_expiration_recovery_ab3') }}
-- recovery at checkout_sessions/after_expiration/recovery from {{ ref('checkout_sessions_after_expiration') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

