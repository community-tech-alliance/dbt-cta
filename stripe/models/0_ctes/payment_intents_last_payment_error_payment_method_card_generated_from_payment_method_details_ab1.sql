{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from') }}
select
    _airbyte_generated_from_hashid,
    {{ json_extract_scalar('payment_method_details', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', 'payment_method_details', ['card_present'], ['card_present']) }} as card_present,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from') }} as table_alias
-- payment_method_details at payment_intents/last_payment_error/payment_method/card/generated_from/payment_method_details
where 1 = 1
and payment_method_details is not null
{{ incremental_clause('_airbyte_emitted_at') }}

