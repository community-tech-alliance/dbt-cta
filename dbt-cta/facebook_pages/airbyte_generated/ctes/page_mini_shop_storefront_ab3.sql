{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_mini_shop_storefront_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'fb_sales_channel',
        'id',
        'ig_sales_channel',
    ]) }} as _airbyte_mini_shop_storefront_hashid,
    tmp.*
from {{ ref('page_mini_shop_storefront_ab2') }} tmp
-- mini_shop_storefront at page/mini_shop_storefront
where 1 = 1

