{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_last_payment_error_hashid',
        'id',
        object_to_string('eps'),
        object_to_string('fpx'),
        object_to_string('p24'),
        object_to_string('card'),
        object_to_string('oxxo'),
        'type',
        object_to_string('ideal'),
        'alipay',
        object_to_string('boleto'),
        'object',
        object_to_string('sofort'),
        'created',
        object_to_string('giropay'),
        object_to_string('grabpay'),
        'customer',
        boolean_to_string('livemode'),
        object_to_string('metadata'),
        object_to_string('acss_debit'),
        object_to_string('bacs_debit'),
        'bancontact',
        object_to_string('sepa_debit'),
        object_to_string('wechat_pay'),
        object_to_string('card_present'),
        object_to_string('au_becs_debit'),
        object_to_string('billing_details'),
        object_to_string('interac_present'),
        'afterpay_clearpay',
    ]) }} as _airbyte_payment_method_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_ab2') }} tmp
-- payment_method at payment_intents/last_payment_error/payment_method
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

