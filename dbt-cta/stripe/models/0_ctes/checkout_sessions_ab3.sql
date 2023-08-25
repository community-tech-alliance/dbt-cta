{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'url',
        'mode',
        'locale',
        'object',
        object_to_string('consent'),
        'currency',
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('shipping'),
        'cancel_url',
        'expires_at',
        'submit_type',
        'success_url',
        'amount_total',
        'setup_intent',
        'subscription',
        object_to_string('automatic_tax'),
        object_to_string('total_details'),
        'customer_email',
        'payment_intent',
        'payment_status',
        'recovered_from',
        'amount_subtotal',
        object_to_string('after_expiration'),
        object_to_string('customer_details'),
        object_to_string('tax_id_collection'),
        object_to_string('consent_collection'),
        'client_reference_id',
        array_to_string('payment_method_types'),
        boolean_to_string('allow_promotion_codes'),
        object_to_string('payment_method_options'),
        object_to_string('phone_number_collection'),
        'billing_address_collection',
        object_to_string('shipping_address_collection'),
    ]) }} as _airbyte_checkout_sessions_hashid,
    tmp.*
from {{ ref('checkout_sessions_ab2') }} as tmp
-- checkout_sessions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

