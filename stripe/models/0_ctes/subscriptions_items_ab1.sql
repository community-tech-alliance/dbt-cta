{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('subscriptions_base') }}
select
    _airbyte_subscriptions_hashid,
    {{ json_extract_scalar('items', ['url'], ['url']) }} as url,
    {{ json_extract_array('items', ['data'], ['data']) }} as data,
    {{ json_extract_scalar('items', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('items', ['has_more'], ['has_more']) }} as has_more,
    {{ json_extract_scalar('items', ['total_count'], ['total_count']) }} as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('subscriptions_base') }} as table_alias
-- items at subscriptions_base/items
where 1 = 1
and items is not null
{{ incremental_clause('_airbyte_emitted_at') }}

