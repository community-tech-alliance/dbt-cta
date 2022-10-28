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
    {{ json_extract_scalar('transform_quantity', ['round'], ['round']) }} as round,
    {{ json_extract_scalar('transform_quantity', ['divide_by'], ['divide_by']) }} as divide_by,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price') }} as table_alias
-- transform_quantity at checkout_sessions_line_items/price/transform_quantity
where 1 = 1
and transform_quantity is not null
{{ incremental_clause('_airbyte_emitted_at') }}

