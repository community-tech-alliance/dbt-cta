{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_checkout_sessions_line_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract('table_alias', '_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_array('_airbyte_data', ['taxes'], ['taxes']) }} as taxes,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_array('_airbyte_data', ['discounts'], ['discounts']) }} as discounts,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['amount_total'], ['amount_total']) }} as amount_total,
    {{ json_extract_scalar('_airbyte_data', ['amount_subtotal'], ['amount_subtotal']) }} as amount_subtotal,
    {{ json_extract_scalar('_airbyte_data', ['checkout_session_id'], ['checkout_session_id']) }} as checkout_session_id,
    {{ json_extract_scalar('_airbyte_data', ['checkout_session_expires_at'], ['checkout_session_expires_at']) }} as checkout_session_expires_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_checkout_sessions_line_items') }} as table_alias
-- checkout_sessions_line_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

