{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_payment_method_details_hashid',
        'type',
        'brand',
        'lsat4',
        'country',
        'funding',
        'network',
        object_to_string('receipt'),
        'exp_year',
        'exp_month',
        'fingerprint',
        'read_method',
        'emv_auth_data',
        'generated_card',
        'cardholder_name',
    ]) }} as _airbyte_card_present_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab2') }} as tmp
-- card_present at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

