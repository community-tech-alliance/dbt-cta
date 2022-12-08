{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_generated_from_ab1') }}
select
    _airbyte_sepa_debit_hashid,
    cast(charge as {{ dbt_utils.type_string() }}) as charge,
    cast(setup_attempt as {{ dbt_utils.type_string() }}) as setup_attempt,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_sepa_debit_generated_from_ab1') }}
-- generated_from at payment_intents_base/last_payment_error/payment_method/sepa_debit/generated_from
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

