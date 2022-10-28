{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('charges_payment_method_details_card') }}
select
    _airbyte_card_hashid,
    {{ json_extract_scalar('card_present', ['brand'], ['brand']) }} as brand,
    {{ json_extract_scalar('card_present', ['last4'], ['last4']) }} as last4,
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_payment_method_details_card') }} as table_alias
-- card_present at charges_base/payment_method_details/card/card_present
where 1 = 1
and card_present is not null
{{ incremental_clause('_airbyte_emitted_at') }}

