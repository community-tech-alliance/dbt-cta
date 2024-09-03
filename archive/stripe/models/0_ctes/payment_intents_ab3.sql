{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'amount',
        'object',
        'review',
        'source',
        'status',
        object_to_string('charges'),
        'created',
        'invoice',
        'currency',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('shipping'),
        'application',
        'canceled_at',
        'description',
        object_to_string('next_action'),
        'on_behalf_of',
        'client_secret',
        'receipt_email',
        object_to_string('transfer_data'),
        'capture_method',
        'payment_method',
        'transfer_group',
        'amount_received',
        'amount_capturable',
        object_to_string('last_payment_error'),
        'setup_future_usage',
        'cancellation_reason',
        'confirmation_method',
        array_to_string('payment_method_types'),
        'statement_description',
        'application_fee_amount',
        object_to_string('payment_method_options'),
        'statement_descriptor_suffix',
    ]) }} as _airbyte_payment_intents_hashid,
    tmp.*
from {{ ref('payment_intents_ab2') }} as tmp
-- payment_intents
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

