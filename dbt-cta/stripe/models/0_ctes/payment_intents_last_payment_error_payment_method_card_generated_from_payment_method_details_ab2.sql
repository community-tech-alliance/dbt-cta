{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_ab1') }}
select
    _airbyte_generated_from_hashid,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(card_present as {{ type_json() }}) as card_present,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_ab1') }}
-- payment_method_details at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

