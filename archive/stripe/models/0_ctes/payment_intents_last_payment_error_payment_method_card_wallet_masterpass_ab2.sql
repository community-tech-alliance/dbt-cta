{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_ab1') }}
select
    _airbyte_wallet_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(billing_address as {{ type_json() }}) as billing_address,
    cast(shipping_address as {{ type_json() }}) as shipping_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_wallet_masterpass_ab1') }}
-- masterpass at payment_intents_base/last_payment_error/payment_method/card/wallet/masterpass
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

