{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_ads_posts_scd'
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
-- depends_on: {{ ref('page_ads_posts_ab3') }}
select
    _airbyte_page_hashid,
    data,
    paging,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ads_posts_hashid
from {{ ref('page_ads_posts_ab3') }}
-- ads_posts at page/ads_posts from {{ ref('page') }}
where 1 = 1

