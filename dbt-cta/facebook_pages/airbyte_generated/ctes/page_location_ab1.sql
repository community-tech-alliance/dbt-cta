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
    {{ json_extract_scalar('location', ['zip'], ['zip']) }} as zip,
    {{ json_extract_scalar('location', ['country'], ['country']) }} as country,
    {{ json_extract_scalar('location', ['city'], ['city']) }} as city,
    {{ json_extract_scalar('location', ['latitude'], ['latitude']) }} as latitude,
    {{ json_extract_scalar('location', ['region_id'], ['region_id']) }} as region_id,
    {{ json_extract_scalar('location', ['country_code'], ['country_code']) }} as country_code,
    {{ json_extract_scalar('location', ['street'], ['street']) }} as street,
    {{ json_extract_scalar('location', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('location', ['located_in'], ['located_in']) }} as located_in,
    {{ json_extract_scalar('location', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('location', ['region'], ['region']) }} as region,
    {{ json_extract_scalar('location', ['city_id'], ['city_id']) }} as city_id,
    {{ json_extract_scalar('location', ['longitude'], ['longitude']) }} as longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- location at page/location
where 1 = 1
and location is not null

