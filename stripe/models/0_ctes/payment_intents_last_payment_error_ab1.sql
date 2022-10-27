{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('payment_intents') }}
select
    _airbyte_payment_intents_hashid,
    {{ json_extract_scalar('last_payment_error', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('last_payment_error', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('last_payment_error', ['param'], ['param']) }} as param,
    {{ json_extract_scalar('last_payment_error', ['charge'], ['charge']) }} as charge,
    {{ json_extract_scalar('last_payment_error', ['doc_url'], ['doc_url']) }} as doc_url,
    {{ json_extract_scalar('last_payment_error', ['message'], ['message']) }} as message,
    {{ json_extract_scalar('last_payment_error', ['decline_code'], ['decline_code']) }} as decline_code,
    {{ json_extract('table_alias', 'last_payment_error', ['payment_method'], ['payment_method']) }} as payment_method,
    {{ json_extract_scalar('last_payment_error', ['payment_method_type'], ['payment_method_type']) }} as payment_method_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payment_intents') }} as table_alias
-- last_payment_error at payment_intents/last_payment_error
where 1 = 1
and last_payment_error is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

