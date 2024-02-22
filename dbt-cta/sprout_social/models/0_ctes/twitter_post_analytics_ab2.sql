{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('twitter_post_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
    'sent',
    'text',
    'lifetime_impressions',
    'lifetime_post_media_views',
    'lifetime_video_views',
    'lifetime_reactions',
    'lifetime_likes',
    'lifetime_comments_count',
    'lifetime_shares_count',
    'lifetime_post_content_clicks',
    'lifetime_post_link_clicks',
    'lifetime_post_content_clicks_other',
    'lifetime_post_media_clicks',
    'lifetime_post_hashtag_clicks',
    'lifetime_post_detail_expand_clicks',
    'lifetime_post_profile_clicks',
    'lifetime_engagements_other',
    'lifetime_post_followers_gained',
    'lifetime_post_followers_lost',
    'lifetime_post_app_engagements',
    'lifetime_post_app_installs',
    'lifetime_post_app_opens',
    'perma_link',
    'created_time',
    'customer_profile_id'
    ]) }} as _airbyte_twitter_post_analytics_hashid
from {{ ref('twitter_post_analytics_ab1') }}
