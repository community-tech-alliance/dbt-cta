{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('subscriptions', ['url'], ['url']) }} as url,
    {{ json_extract_array('subscriptions', ['data'], ['data']) }} as data,
    {{ json_extract_scalar('subscriptions', ['object'], ['object']) }} as object,
    {{ json_extract_scalar('subscriptions', ['has_more'], ['has_more']) }} as has_more,
    {{ json_extract_scalar('subscriptions', ['total_count'], ['total_count']) }} as total_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- subscriptions at customers/subscriptions
where 1 = 1
and subscriptions is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

