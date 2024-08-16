{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_three_d_secure_usage_ab1') }}
select
    _airbyte_card_hashid,
    {{ cast_to_boolean('supported') }} as supported,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_three_d_secure_usage_ab1') }}
-- three_d_secure_usage at payment_intents_base/last_payment_error/payment_method/card/three_d_secure_usage
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

