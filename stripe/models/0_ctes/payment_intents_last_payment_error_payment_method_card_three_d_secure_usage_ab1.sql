{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('three_d_secure_usage', ['supported'], ['supported']) }} as supported,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card') }} as table_alias
-- three_d_secure_usage at payment_intents/last_payment_error/payment_method/card/three_d_secure_usage
where 1 = 1
and three_d_secure_usage is not null
{{ incremental_clause('_airbyte_emitted_at') }}

