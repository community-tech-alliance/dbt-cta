{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_au_becs_debit_ab1') }}
select
    _airbyte_payment_method_hashid,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(bsb_number as {{ dbt_utils.type_string() }}) as bsb_number,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_au_becs_debit_ab1') }}
-- au_becs_debit at payment_intents/last_payment_error/payment_method/au_becs_debit
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

