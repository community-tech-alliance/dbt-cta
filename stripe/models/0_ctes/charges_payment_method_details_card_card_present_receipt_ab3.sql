{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('charges_payment_method_details_card_card_present_receipt_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_card_present_hashid',
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
from {{ ref('charges_payment_method_details_card_card_present_receipt_ab2') }} tmp
-- receipt at charges_base/payment_method_details/card/card_present/receipt
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

