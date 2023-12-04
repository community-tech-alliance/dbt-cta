{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('page_mini_shop_storefront_ab1') }}
select
    _airbyte_page_hashid,
    cast(fb_sales_channel as {{ dbt_utils.type_string() }}) as fb_sales_channel,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(ig_sales_channel as {{ dbt_utils.type_string() }}) as ig_sales_channel,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('page_mini_shop_storefront_ab1') }}
-- mini_shop_storefront at page/mini_shop_storefront
where 1 = 1

