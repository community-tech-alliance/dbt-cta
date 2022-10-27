{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab1') }}
select
    _airbyte_card_present_hashid,
    cast(account_type as {{ dbt_utils.type_string() }}) as account_type,
    cast(authorization_code as {{ dbt_utils.type_string() }}) as authorization_code,
    cast(dedicated_file_name as {{ dbt_utils.type_string() }}) as dedicated_file_name,
    cast(application_cryptogram as {{ dbt_utils.type_string() }}) as application_cryptogram,
    cast(application_preferred_name as {{ dbt_utils.type_string() }}) as application_preferred_name,
    cast(authorization_response_code as {{ dbt_utils.type_string() }}) as authorization_response_code,
    cast(terminal_verification_results as {{ dbt_utils.type_string() }}) as terminal_verification_results,
    cast(cardholder_verification_method as {{ dbt_utils.type_string() }}) as cardholder_verification_method,
    cast(transaction_status_information as {{ dbt_utils.type_string() }}) as transaction_status_information,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_receipt_ab1') }}
-- receipt at payment_intents/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present/receipt
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

