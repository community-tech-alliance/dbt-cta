{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_visa_checkout_billing_address_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_visa_checkout_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_billing_address_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_wallet_visa_checkout_billing_address_ab2') }} tmp
-- billing_address at charges/payment_method_details/card/wallet/visa_checkout/billing_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

