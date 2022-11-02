{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_wallet_masterpass_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_wallet_hashid',
        'name',
        'email',
        object_to_string('billing_address'),
        object_to_string('shipping_address'),
    ]) }} as _airbyte_masterpass_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_wallet_masterpass_ab2') }} tmp
-- masterpass at charges_base/payment_method_details/card/wallet/masterpass
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

