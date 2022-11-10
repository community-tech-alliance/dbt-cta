{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab3') }}
select
    _airbyte_acss_debit_hashid,
    default_for,
    payment_schedule,
    transaction_type,
    custom_mandate_url,
    interval_description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mandate_options_hashid
from {{ ref('checkout_sessions_payment_method_options_acss_debit_mandate_options_ab3') }}
-- mandate_options at checkout_sessions_base/payment_method_options/acss_debit/mandate_options from {{ ref('checkout_sessions_payment_method_options_acss_debit_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

