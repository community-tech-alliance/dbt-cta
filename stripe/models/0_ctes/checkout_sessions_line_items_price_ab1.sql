{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_line_items') }}
select
    _airbyte_checkout_sessions_line_items_hashid,
    {{ json_extract_scalar('price', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('price', ['type'], ['type']) }} as type,
    {{ json_extract('table_alias', 'price', ['tiers'], ['tiers']) }} as tiers,
    {{ json_extract_scalar('price', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('price', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('price', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('price', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('price', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('price', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'price', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('price', ['nickname'], ['nickname']) }} as nickname,
    {{ json_extract('table_alias', 'price', ['recurring'], ['recurring']) }} as recurring,
    {{ json_extract_scalar('price', ['lookup_key'], ['lookup_key']) }} as lookup_key,
    {{ json_extract_scalar('price', ['tiers_mode'], ['tiers_mode']) }} as tiers_mode,
    {{ json_extract_scalar('price', ['unit_amount'], ['unit_amount']) }} as unit_amount,
    {{ json_extract_scalar('price', ['tax_behavior'], ['tax_behavior']) }} as tax_behavior,
    {{ json_extract_scalar('price', ['billing_scheme'], ['billing_scheme']) }} as billing_scheme,
    {{ json_extract('table_alias', 'price', ['transform_quantity'], ['transform_quantity']) }} as transform_quantity,
    {{ json_extract_scalar('price', ['unit_amount_decimal'], ['unit_amount_decimal']) }} as unit_amount_decimal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items') }} as table_alias
-- price at checkout_sessions_line_items/price
where 1 = 1
and price is not null
{{ incremental_clause('_airbyte_emitted_at') }}

