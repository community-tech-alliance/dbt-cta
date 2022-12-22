{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_three_d_secure_usage_ab3') }}
select
    _airbyte_card_hashid,
    supported,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_three_d_secure_usage_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_card_three_d_secure_usage_ab3') }}
-- three_d_secure_usage at payment_intents_base/last_payment_error/payment_method/card/three_d_secure_usage from {{ ref('payment_intents_last_payment_error_payment_method_card_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
