{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('stripe_partner_a', '_airbyte_raw_invoices') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['tax'], ['tax']) }} as tax,
    {{ json_extract_scalar('_airbyte_data', ['paid'], ['paid']) }} as paid,
    {{ json_extract_string_array('_airbyte_data', ['lines'], ['lines']) }} as lines,
    {{ json_extract_scalar('_airbyte_data', ['total'], ['total']) }} as total,
    {{ json_extract_scalar('_airbyte_data', ['charge'], ['charge']) }} as charge,
    {{ json_extract_scalar('_airbyte_data', ['closed'], ['closed']) }} as closed,
    {{ json_extract_scalar('_airbyte_data', ['number'], ['number']) }} as number,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['billing'], ['billing']) }} as billing,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['payment'], ['payment']) }} as payment,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['discount'], ['discount']) }} as discount,
    {{ json_extract_scalar('_airbyte_data', ['due_date'], ['due_date']) }} as due_date,
    {{ json_extract_scalar('_airbyte_data', ['forgiven'], ['forgiven']) }} as forgiven,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['subtotal'], ['subtotal']) }} as subtotal,
    {{ json_extract_scalar('_airbyte_data', ['attempted'], ['attempted']) }} as attempted,
    {{ json_extract_array('_airbyte_data', ['discounts'], ['discounts']) }} as discounts,
    {{ json_extract_scalar('_airbyte_data', ['amount_due'], ['amount_due']) }} as amount_due,
    {{ json_extract_scalar('_airbyte_data', ['period_end'], ['period_end']) }} as period_end,
    {{ json_extract_scalar('_airbyte_data', ['amount_paid'], ['amount_paid']) }} as amount_paid,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['invoice_pdf'], ['invoice_pdf']) }} as invoice_pdf,
    {{ json_extract_scalar('_airbyte_data', ['tax_percent'], ['tax_percent']) }} as tax_percent,
    {{ json_extract_scalar('_airbyte_data', ['auto_advance'], ['auto_advance']) }} as auto_advance,
    {{ json_extract_scalar('_airbyte_data', ['period_start'], ['period_start']) }} as period_start,
    {{ json_extract_scalar('_airbyte_data', ['subscription'], ['subscription']) }} as subscription,
    {{ json_extract_scalar('_airbyte_data', ['attempt_count'], ['attempt_count']) }} as attempt_count,
    {{ json_extract_scalar('_airbyte_data', ['billing_reason'], ['billing_reason']) }} as billing_reason,
    {{ json_extract_scalar('_airbyte_data', ['ending_balance'], ['ending_balance']) }} as ending_balance,
    {{ json_extract_scalar('_airbyte_data', ['receipt_number'], ['receipt_number']) }} as receipt_number,
    {{ json_extract_scalar('_airbyte_data', ['application_fee'], ['application_fee']) }} as application_fee,
    {{ json_extract_scalar('_airbyte_data', ['amount_remaining'], ['amount_remaining']) }} as amount_remaining,
    {{ json_extract_scalar('_airbyte_data', ['starting_balance'], ['starting_balance']) }} as starting_balance,
    {{ json_extract_scalar('_airbyte_data', ['hosted_invoice_url'], ['hosted_invoice_url']) }} as hosted_invoice_url,
    {{ json_extract_scalar('_airbyte_data', ['next_payment_attempt'], ['next_payment_attempt']) }} as next_payment_attempt,
    {{ json_extract_scalar('_airbyte_data', ['statement_descriptor'], ['statement_descriptor']) }} as statement_descriptor,
    {{ json_extract_scalar('_airbyte_data', ['statement_description'], ['statement_description']) }} as statement_description,
    {{ json_extract_scalar('_airbyte_data', ['webhooks_delivered_at'], ['webhooks_delivered_at']) }} as webhooks_delivered_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('stripe_partner_a', '_airbyte_raw_invoices') }} as table_alias
-- invoices
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

