{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_ab3') }}
select
    id,
    url,
    mode,
    locale,
    object,
    consent,
    currency,
    customer,
    livemode,
    metadata,
    shipping,
    cancel_url,
    expires_at,
    submit_type,
    success_url,
    amount_total,
    setup_intent,
    subscription,
    automatic_tax,
    total_details,
    customer_email,
    payment_intent,
    payment_status,
    recovered_from,
    amount_subtotal,
    after_expiration,
    customer_details,
    tax_id_collection,
    consent_collection,
    client_reference_id,
    payment_method_types,
    allow_promotion_codes,
    payment_method_options,
    phone_number_collection,
    billing_address_collection,
    shipping_address_collection,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_checkout_sessions_hashid
from {{ ref('checkout_sessions_ab3') }}
-- checkout_sessions from {{ source('cta', '_airbyte_raw_checkout_sessions') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

