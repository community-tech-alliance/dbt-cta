{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_shipping_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_masterpass_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_shipping_address_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_shipping_address_ab2') }} tmp
-- shipping_address at payment_intents_base/last_payment_error/payment_method/card/wallet/masterpass/shipping_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

