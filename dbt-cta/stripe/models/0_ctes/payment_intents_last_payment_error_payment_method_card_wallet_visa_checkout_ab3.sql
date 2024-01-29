{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_wallet_hashid',
        'name',
        'email',
        object_to_string('billing_address'),
        object_to_string('shipping_address'),
    ]) }} as _airbyte_visa_checkout_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_visa_checkout_ab2') }} as tmp
-- visa_checkout at payment_intents_base/last_payment_error/payment_method/card/wallet/visa_checkout
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

