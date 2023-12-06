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
    {{ json_extract_scalar('mini_shop_storefront', ['fb_sales_channel'], ['fb_sales_channel']) }} as fb_sales_channel,
    {{ json_extract_scalar('mini_shop_storefront', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('mini_shop_storefront', ['ig_sales_channel'], ['ig_sales_channel']) }} as ig_sales_channel,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page') }} as table_alias
-- mini_shop_storefront at page/mini_shop_storefront
where 1 = 1
and mini_shop_storefront is not null

