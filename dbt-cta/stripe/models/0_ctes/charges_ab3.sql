{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('card'),
        boolean_to_string('paid'),
        adapter.quote('order'),
        'amount',
        'object',
        'review',
        object_to_string('source'),
        'status',
        'created',
        'dispute',
        'invoice',
        object_to_string('outcome'),
        object_to_string('refunds'),
        boolean_to_string('captured'),
        'currency',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        boolean_to_string('refunded'),
        object_to_string('shipping'),
        'application',
        'description',
        'destination',
        'failure_code',
        'on_behalf_of',
        object_to_string('fraud_details'),
        'receipt_email',
        'payment_intent',
        'receipt_number',
        'transfer_group',
        'amount_refunded',
        'application_fee',
        'failure_message',
        'source_transfer',
        'balance_transaction',
        'statement_descriptor',
        'statement_description',
        object_to_string('payment_method_details'),
    ]) }} as _airbyte_charges_hashid,
    tmp.*
from {{ ref('charges_ab2') }} as tmp
-- charges
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

