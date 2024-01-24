{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('instagram_profile_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
    'customer_profile_id',
    'reporting_period_day',
    'lifetime_snapshot_followers_count',
    'lifetime_snapshot_followers_by_country',
    'lifetime_snapshot_followers_by_age_gender',
    'lifetime_snapshot_followers_by_city',
    'lifetime_snapshot_following_count',
    'net_follower_growth',
    'followers_gained',
    'followers_lost',
    'impressions',
    'impressions_unique',
    'profile_views_unique',
    'video_views',
    'reactions',
    'comments_count',
    'shares_count',
    'likes',
    'saves',
    'story_replies',
    'email_contacts',
    'get_directions_clicks',
    'phone_call_clicks',
    'text_message_clicks',
    'website_clicks',
    'posts_sent_count',
    'posts_sent_by_post_type',
    'posts_sent_by_content_type',
    ]) }} as _airbyte_instagram_profile_analytics_hashid
from {{ ref('instagram_profile_analytics_ab1') }}
