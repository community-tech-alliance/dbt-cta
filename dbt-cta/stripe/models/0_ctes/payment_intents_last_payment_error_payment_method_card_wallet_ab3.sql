{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'type',
        'apple_pay',
        'google_pay',
        object_to_string('masterpass'),
        'samsung_pay',
        'dynamic_last4',
        object_to_string('visa_checkout'),
        'amex_express_checkout',
    ]) }} as _airbyte_wallet_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_ab2') }} tmp
-- wallet at payment_intents_base/last_payment_error/payment_method/card/wallet
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

