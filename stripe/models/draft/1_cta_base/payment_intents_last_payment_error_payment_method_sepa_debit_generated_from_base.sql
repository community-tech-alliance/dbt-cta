{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_generated_from_ab3') }}
select
    _airbyte_sepa_debit_hashid,
    charge,
    setup_attempt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_generated_from_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_generated_from_ab3') }}
-- generated_from at payment_intents/last_payment_error/payment_method/sepa_debit/generated_from from {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

