{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_visa_checkout_shipping_address_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_visa_checkout_hashid',
        'city',
        'line1',
        'line2',
        'state',
        'country',
        'postal_code',
    ]) }} as _airbyte_shipping_address_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_wallet_visa_checkout_shipping_address_ab2') }} as tmp
-- shipping_address at charges_base/payment_method_details/card/wallet/visa_checkout/shipping_address
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

