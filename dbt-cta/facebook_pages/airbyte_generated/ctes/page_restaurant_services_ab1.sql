{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('page') }}
select
    _airbyte_page_hashid,
    {{ json_extract_scalar('restaurant_services', ['outdoor'], ['outdoor']) }} as outdoor,
    {{ json_extract_scalar('restaurant_services', ['delivery'], ['delivery']) }} as delivery,
    {{ json_extract_scalar('restaurant_services', ['reserve'], ['reserve']) }} as reserve,
    {{ json_extract_scalar('restaurant_services', ['catering'], ['catering']) }} as catering,
    {{ json_extract_scalar('restaurant_services', ['groups'], ['groups']) }} as {{ adapter.quote('groups') }},
    {{ json_extract_scalar('restaurant_services', ['pickup'], ['pickup']) }} as pickup,
    {{ json_extract_scalar('restaurant_services', ['walkins'], ['walkins']) }} as walkins,
    {{ json_extract_scalar('restaurant_services', ['waiter'], ['waiter']) }} as waiter,
    {{ json_extract_scalar('restaurant_services', ['takeout'], ['takeout']) }} as takeout,
    {{ json_extract_scalar('restaurant_services', ['kids'], ['kids']) }} as kids,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- restaurant_services at page/restaurant_services
where 1 = 1
and restaurant_services is not null

