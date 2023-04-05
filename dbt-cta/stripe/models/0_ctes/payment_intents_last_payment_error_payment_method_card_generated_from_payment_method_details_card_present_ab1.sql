{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_base') }}
select
    _airbyte_payment_method_details_hashid,
    {{ json_extract_scalar('card_present', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('card_present', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('card_present', ['lsat4'], ['lsat4']) }} as lsat4,
    {{ json_extract_scalar('card_present', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('card_present', ['funding'], ['funding']) }} as funding,
    {{ json_extract_scalar('card_present', ['network'], ['network']) }} as network,
    {{ json_extract('table_alias', 'card_present', ['receipt'], ['receipt']) }} as receipt,
    {{ json_extract_scalar('card_present', ['exp_year'], ['exp_year']) }} as exp_year,
    {{ json_extract_scalar('card_present', ['exp_month'], ['exp_month']) }} as exp_month,
    {{ json_extract_scalar('card_present', ['fingerprint'], ['fingerprint']) }} as fingerprint,
    {{ json_extract_scalar('card_present', ['read_method'], ['read_method']) }} as read_method,
    {{ json_extract_scalar('card_present', ['emv_auth_data'], ['emv_auth_data']) }} as emv_auth_data,
    {{ json_extract_scalar('card_present', ['generated_card'], ['generated_card']) }} as generated_card,
    {{ json_extract_scalar('card_present', ['cardholder_name'], ['cardholder_name']) }} as cardholder_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents_last_payment_error_payment_method_card_generated_from_payment_method_details_base') }} as table_alias
-- card_present at payment_intents_base/last_payment_error/payment_method/card/generated_from/payment_method_details/card_present
where 1 = 1
and card_present is not null
{{ incremental_clause('_airbyte_emitted_at') }}

