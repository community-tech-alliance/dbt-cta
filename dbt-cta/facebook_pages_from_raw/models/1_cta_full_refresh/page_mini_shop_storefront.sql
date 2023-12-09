{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_mini_shop_storefront_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('page_mini_shop_storefront_ab3') }}
select
    _airbyte_page_hashid,
    fb_sales_channel,
    id,
    ig_sales_channel,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mini_shop_storefront_hashid
from {{ ref('page_mini_shop_storefront_ab3') }}
-- mini_shop_storefront at page/mini_shop_storefront from {{ ref('page') }}
where 1 = 1

