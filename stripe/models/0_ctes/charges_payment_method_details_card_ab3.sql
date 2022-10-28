{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_details_hashid',
        'id',
        object_to_string('eps'),
        object_to_string('p24'),
        'name',
        'type',
        'brand',
        object_to_string('ideal'),
        'last4',
        object_to_string('checks'),
        object_to_string('klarna'),
        'object',
        object_to_string('sofort'),
        object_to_string('wallet'),
        object_to_string('wechat'),
        'country',
        'funding',
        object_to_string('giropay'),
        'network',
        'customer',
        'exp_year',
        object_to_string('metadata'),
        'cvc_check',
        'exp_month',
        object_to_string('multibanco'),
        object_to_string('sepa_debit'),
        'address_zip',
        'fingerprint',
        'address_city',
        object_to_string('card_present'),
        object_to_string('installments'),
        'address_line1',
        'address_line2',
        'address_state',
        'dynamic_last4',
        object_to_string('stripe_account'),
        object_to_string('three_d_secure'),
        'address_country',
        'address_zip_check',
        'address_line1_check',
        'tokenization_method',
    ]) }} as _airbyte_card_hashid,
    tmp.*
from {{ ref('charges_payment_method_details_card_ab2') }} tmp
-- card at charges/payment_method_details/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

