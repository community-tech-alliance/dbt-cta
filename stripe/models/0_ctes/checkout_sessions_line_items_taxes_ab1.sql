{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('checkout_sessions_line_items') }}
{{ unnest_cte(ref('checkout_sessions_line_items'), 'checkout_sessions_line_items', 'taxes') }}
select
    _airbyte_checkout_sessions_line_items_hashid,
    {{ json_extract('', unnested_column_value('taxes'), ['rate'], ['rate']) }} as rate,
    {{ json_extract('', unnested_column_value('taxes'), ['amount']) }} as amount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items') }} as table_alias
-- taxes at checkout_sessions_line_items/taxes
{{ cross_join_unnest('checkout_sessions_line_items', 'taxes') }}
where 1 = 1
and taxes is not null
{{ incremental_clause('_airbyte_emitted_at') }}

