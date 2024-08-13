{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_invoices_hashid',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoices_ab3') }}
select
    id,
    tax,
    paid,
    lines,
    total,
    charge,
    closed,
    number,
    object,
    status,
    billing,
    created,
    payment,
    currency,
    customer,
    discount,
    due_date,
    forgiven,
    livemode,
    metadata,
    subtotal,
    attempted,
    discounts,
    amount_due,
    period_end,
    amount_paid,
    description,
    invoice_pdf,
    tax_percent,
    auto_advance,
    period_start,
    subscription,
    attempt_count,
    billing_reason,
    ending_balance,
    receipt_number,
    application_fee,
    amount_remaining,
    starting_balance,
    hosted_invoice_url,
    next_payment_attempt,
    statement_descriptor,
    statement_description,
    webhooks_delivered_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_invoices_hashid
from {{ ref('invoices_ab3') }}
-- invoices from {{ source('cta', '_airbyte_raw_invoices') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

