{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_billing_details_address_ab3') }}
select
    _airbyte_billing_details_hashid,
    city,
    line1,
    line2,
    state,
    country,
    postal_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_address_hashid
from {{ ref('payment_intents_last_payment_error_payment_method_billing_details_address_ab3') }}
-- address at payment_intents/last_payment_error/payment_method/billing_details/address from {{ ref('payment_intents_last_payment_error_payment_method_billing_details') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

