{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('twitter_profile_analytics_ab1') }}

select
    *,
    -- to do: add all unnested fields and all fields to surrogate_key
   {{ dbt_utils.surrogate_key([
    'comments_count',
    'engagements',
    'impressions',
    'lifetime_snapshot_followers_count',
    'likes',
    'new_follower_growth',
    'post_app_engagements',
    'post_app_installs',
    'post_app_opens',
    'post_content_clicks',
    'post_detail_expand_clicks',
    'post_hashtag_clicks',
    'post_link_clicks',
    'post_media_clicks',
    'post_media_clicks',
    'shares_count',
    'video_views',
    'customer_profile_id',
    'reporting_period_day' 
    ]) }} as _airbyte_twitter_profile_analytics_hashid
from {{ ref('twitter_profile_analytics_ab1') }}
