{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_ab3') }}
select
    _airbyte_payment_method_options_hashid,
    currency,
    mandate_options,
    verification_method,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_acss_debit_hashid
from {{ ref('checkout_sessions_payment_method_options_acss_debit_ab3') }}
-- acss_debit at checkout_sessions_base/payment_method_options/acss_debit from {{ ref('checkout_sessions_payment_method_options_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

