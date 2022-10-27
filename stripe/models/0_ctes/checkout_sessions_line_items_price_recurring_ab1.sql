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
    {{ json_extract_scalar('recurring', ['interval'], ['interval']) }} as {{ adapter.quote('interval') }},
    {{ json_extract_scalar('recurring', ['usage_type'], ['usage_type']) }} as usage_type,
    {{ json_extract_scalar('recurring', ['interval_count'], ['interval_count']) }} as interval_count,
    {{ json_extract_scalar('recurring', ['aggregate_usage'], ['aggregate_usage']) }} as aggregate_usage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price') }} as table_alias
-- recurring at checkout_sessions_line_items/price/recurring
where 1 = 1
and recurring is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

