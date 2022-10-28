{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_line_items_taxes') }}
select
    _airbyte_taxes_hashid,
    {{ json_extract_scalar('rate', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('rate', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('rate', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('rate', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('rate', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('rate', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('rate', ['livemode'], ['livemode']) }} as livemode,
    {{ json_extract('table_alias', 'rate', ['metadata'], ['metadata']) }} as metadata,
    {{ json_extract_scalar('rate', ['tax_type'], ['tax_type']) }} as tax_type,
    {{ json_extract_scalar('rate', ['inclusive'], ['inclusive']) }} as inclusive,
    {{ json_extract_scalar('rate', ['percentage'], ['percentage']) }} as percentage,
    {{ json_extract_scalar('rate', ['description'], ['description']) }} as description,
    {{ json_extract_scalar('rate', ['display_name'], ['display_name']) }} as display_name,
    {{ json_extract_scalar('rate', ['jurisdiction'], ['jurisdiction']) }} as jurisdiction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_taxes') }} as table_alias
-- rate at checkout_sessions_line_items/taxes/rate
where 1 = 1
and rate is not null
{{ incremental_clause('_airbyte_emitted_at') }}

