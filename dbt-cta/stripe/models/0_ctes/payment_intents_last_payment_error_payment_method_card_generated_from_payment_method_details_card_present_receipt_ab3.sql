{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_card_present_hashid',
        'account_type',
        'authorization_code',
        'dedicated_file_name',
        'application_cryptogram',
        'application_preferred_name',
        'authorization_response_code',
        'terminal_verification_results',
        'cardholder_verification_method',
        'transaction_status_information',
    ]) }} as _airbyte_receipt_hashid,
    tmp.*
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab2') }} as tmp
-- receipt at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present/receipt
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

