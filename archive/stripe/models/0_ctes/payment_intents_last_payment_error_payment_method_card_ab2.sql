{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_ab1') }}
select
    _airbyte_payment_method_hashid,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(last4 as {{ dbt_utils.type_string() }}) as last4,
    cast(checks as {{ type_json() }}) as checks,
    cast(wallet as {{ type_json() }}) as wallet,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(networks as {{ type_json() }}) as networks,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(generated_from as {{ type_json() }}) as generated_from,
    cast(three_d_secure_usage as {{ type_json() }}) as three_d_secure_usage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_ab1') }}
-- card at payment_intents_base/last_payment_error/payment_method/card
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

