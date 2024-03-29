{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_base') }}
select
    _airbyte_discounts_hashid,
    {{ json_extract_scalar('discount', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('discount', ['end'], ['end']) }} as {{ adapter.quote('end') }},
    {{ json_extract_scalar('discount', ['start'], ['start']) }} as start,
    {{ json_extract('table_alias', 'discount', ['coupon'], ['coupon']) }} as coupon,
    {{ json_extract_scalar('discount', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('discount', ['invoice'], ['invoice']) }} as invoice,
    {{ json_extract_scalar('discount', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('discount', ['invoice_item'], ['invoice_item']) }} as invoice_item,
    {{ json_extract_scalar('discount', ['subscription'], ['subscription']) }} as subscription,
    {{ json_extract_scalar('discount', ['promotion_code'], ['promotion_code']) }} as promotion_code,
    {{ json_extract_scalar('discount', ['checkout_session'], ['checkout_session']) }} as checkout_session,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_discounts_base') }} as table_alias
-- discount at checkout_sessions_line_items/discounts/discount
where
    1 = 1
    and discount is not null
{{ incremental_clause('_airbyte_emitted_at') }}

