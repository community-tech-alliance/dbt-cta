{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_instagram_business_account_scd'
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
-- depends_on: {{ ref('page_instagram_business_account_ab3') }}
select
    _airbyte_page_hashid,
    website,
    shopping_review_status,
    media_count,
    followers_count,
    profile_picture_url,
    name,
    follows_count,
    id,
    ig_id,
    biography,
    username,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_instagram_business_account_hashid
from {{ ref('page_instagram_business_account_ab3') }}
-- instagram_business_account at page/instagram_business_account from {{ ref('page') }}
where 1 = 1

