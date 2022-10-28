{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_checks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_hashid',
        'cvc_check',
        'address_line1_check',
        'address_postal_code_check',
    ]) }} as _airbyte_checks_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_checks_ab2') }} tmp
-- checks at payment_intents/last_payment_error/payment_method/card/checks
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

