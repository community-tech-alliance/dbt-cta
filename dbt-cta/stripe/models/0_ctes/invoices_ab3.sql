{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'tax',
        boolean_to_string('paid'),
        array_to_string('lines'),
        'total',
        'charge',
        boolean_to_string('closed'),
        'number',
        'object',
        'status',
        'billing',
        'created',
        'payment',
        'currency',
        'customer',
        'discount',
        'due_date',
        boolean_to_string('forgiven'),
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        'subtotal',
        boolean_to_string('attempted'),
        array_to_string('discounts'),
        'amount_due',
        'period_end',
        'amount_paid',
        'description',
        'invoice_pdf',
        'tax_percent',
        boolean_to_string('auto_advance'),
        'period_start',
        'subscription',
        'attempt_count',
        'billing_reason',
        'ending_balance',
        'receipt_number',
        'application_fee',
        'amount_remaining',
        'starting_balance',
        'hosted_invoice_url',
        'next_payment_attempt',
        'statement_descriptor',
        'statement_description',
        'webhooks_delivered_at',
    ]) }} as _airbyte_invoices_hashid,
    tmp.*
from {{ ref('invoices_ab2') }} tmp
-- invoices
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

