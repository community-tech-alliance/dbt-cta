{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payment_intents_ab3') }}
select
    id,
    amount,
    object,
    review,
    source,
    status,
    charges,
    created,
    invoice,
    currency,
    customer,
    livemode,
    metadata,
    shipping,
    application,
    canceled_at,
    description,
    next_action,
    on_behalf_of,
    client_secret,
    receipt_email,
    transfer_data,
    capture_method,
    payment_method,
    transfer_group,
    amount_received,
    amount_capturable,
    last_payment_error,
    setup_future_usage,
    cancellation_reason,
    confirmation_method,
    payment_method_types,
    statement_description,
    application_fee_amount,
    payment_method_options,
    statement_descriptor_suffix,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payment_intents_hashid
from {{ ref('payment_intents_ab3') }}
-- payment_intents from {{ source('cta', '_airbyte_raw_payment_intents') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

