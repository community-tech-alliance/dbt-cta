{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_payment_method_options_ab1') }}
select
    _airbyte_checkout_sessions_hashid,
    cast(oxxo as {{ type_json() }}) as oxxo,
    cast(boleto as {{ type_json() }}) as boleto,
    cast(acss_debit as {{ type_json() }}) as acss_debit,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_payment_method_options_ab1') }}
-- payment_method_options at checkout_sessions/payment_method_options
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

