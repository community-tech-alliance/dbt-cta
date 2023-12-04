{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "default",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='page_connected_instagram_account_scd'
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
-- depends_on: {{ ref('page_connected_instagram_account_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_connected_instagram_account_hashid
from {{ ref('page_connected_instagram_account_ab3') }}
-- connected_instagram_account at page/connected_instagram_account from {{ ref('page') }}
where 1 = 1

