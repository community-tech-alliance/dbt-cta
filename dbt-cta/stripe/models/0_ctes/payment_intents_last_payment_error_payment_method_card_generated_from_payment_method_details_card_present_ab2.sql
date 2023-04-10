{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab1') }}
select
    _airbyte_payment_method_details_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(brand as {{ dbt_utils.type_string() }}) as brand,
    cast(lsat4 as {{ dbt_utils.type_string() }}) as lsat4,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(funding as {{ dbt_utils.type_string() }}) as funding,
    cast(network as {{ dbt_utils.type_string() }}) as network,
    cast(receipt as {{ type_json() }}) as receipt,
    cast(exp_year as {{ dbt_utils.type_bigint() }}) as exp_year,
    cast(exp_month as {{ dbt_utils.type_bigint() }}) as exp_month,
    cast(fingerprint as {{ dbt_utils.type_string() }}) as fingerprint,
    cast(read_method as {{ dbt_utils.type_string() }}) as read_method,
    cast(emv_auth_data as {{ dbt_utils.type_string() }}) as emv_auth_data,
    cast(generated_card as {{ dbt_utils.type_string() }}) as generated_card,
    cast(cardholder_name as {{ dbt_utils.type_string() }}) as cardholder_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_card_present_ab1') }}
-- card_present at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

