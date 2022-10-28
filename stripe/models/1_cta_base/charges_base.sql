{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('charges_ab3') }}
select
    id,
    card,
    paid,
    {{ adapter.quote('order') }},
    amount,
    object,
    review,
    source,
    status,
    created,
    dispute,
    invoice,
    outcome,
    refunds,
    captured,
    currency,
    customer,
    livemode,
    metadata,
    refunded,
    shipping,
    application,
    description,
    destination,
    failure_code,
    on_behalf_of,
    fraud_details,
    receipt_email,
    payment_intent,
    receipt_number,
    transfer_group,
    amount_refunded,
    application_fee,
    failure_message,
    source_transfer,
    balance_transaction,
    statement_descriptor,
    statement_description,
    payment_method_details,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_charges_hashid
from {{ ref('charges_ab3') }}
-- charges from {{ source('stripe_partner_a', '_airbyte_raw_charges') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

