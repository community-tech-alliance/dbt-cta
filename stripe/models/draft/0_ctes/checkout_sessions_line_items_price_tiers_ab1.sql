{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_line_items_price') }}
select
    _airbyte_price_hashid,
    {{ json_extract_scalar('tiers', ['up_to'], ['up_to']) }} as up_to,
    {{ json_extract_scalar('tiers', ['flat_amount'], ['flat_amount']) }} as flat_amount,
    {{ json_extract_scalar('tiers', ['unit_amount'], ['unit_amount']) }} as unit_amount,
    {{ json_extract_scalar('tiers', ['flat_amount_decimal'], ['flat_amount_decimal']) }} as flat_amount_decimal,
    {{ json_extract_scalar('tiers', ['unit_amount_decimal'], ['unit_amount_decimal']) }} as unit_amount_decimal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price') }} as table_alias
-- tiers at checkout_sessions_line_items/price/tiers
where 1 = 1
and tiers is not null
{{ incremental_clause('_airbyte_emitted_at') }}

