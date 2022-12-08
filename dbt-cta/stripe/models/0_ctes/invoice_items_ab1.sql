{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_invoice_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['date'], ['date']) }} as date,
    {{ json_extract('table_alias', '_airbyte_data', ['plan'], ['plan']) }} as plan,
    {{ json_extract_scalar('_airbyte_data', ['amount'], ['amount']) }} as amount,
    {{ json_extract_scalar('_airbyte_data', ['object'], ['object']) }} as object,
    {{ json_extract('table_alias', '_airbyte_data', ['period'], ['period']) }} as period,
    {{ json_extract_scalar('_airbyte_data', ['invoice'], ['invoice']) }} as invoice,
    {{ json_extract_scalar('_airbyte_data', ['currency'], ['currency']) }} as currency,
    {{ json_extract_scalar('_airbyte_data', ['customer'], ['customer']) }} as customer,
    {{ json_extract_scalar('_airbyte_data', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', '_airbyte_data', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('_airbyte_data', ['quantity'], ['quantity']) }} as quantity,
    {{ json_extract_scalar('_airbyte_data', ['proration'], ['proration']) }} as proration,
    {{ json_extract_scalar('_airbyte_data', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('_airbyte_data', ['unit_amount'], ['unit_amount']) }} as unit_amount,
    {{ json_extract_scalar('_airbyte_data', ['discountable'], ['discountable']) }} as discountable,
    {{ json_extract_scalar('_airbyte_data', ['subscription'], ['subscription']) }} as subscription,
    {{ json_extract_scalar('_airbyte_data', ['subscription_item'], ['subscription_item']) }} as subscription_item,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_invoice_items') }} as table_alias
-- invoice_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

