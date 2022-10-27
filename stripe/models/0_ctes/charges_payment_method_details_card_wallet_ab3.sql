{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'type',
        object_to_string('apple_pay'),
        object_to_string('google_pay'),
        object_to_string('masterpass'),
        object_to_string('samsung_pay'),
        'dynamic_last4',
        object_to_string('visa_checkout'),
        object_to_string('amex_express_checkout'),
    ]) }} as _airbyte_wallet_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_wallet_ab2') }} tmp
-- wallet at charges/payment_method_details/card/wallet
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

