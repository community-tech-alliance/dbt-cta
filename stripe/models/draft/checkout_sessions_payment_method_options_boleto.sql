{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_payment_method_options_boleto_ab3') }}
select
    _airbyte_payment_method_options_hashid,
    expires_after_days,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_boleto_hashid
from {{ ref('checkout_sessions_payment_method_options_boleto_ab3') }}
-- boleto at checkout_sessions/payment_method_options/boleto from {{ ref('checkout_sessions_payment_method_options') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

