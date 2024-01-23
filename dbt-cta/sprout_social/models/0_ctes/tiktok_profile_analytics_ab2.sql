{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tiktok_profile_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
    'customer_profile_id',
    'reporting_period_day',
    'lifetime_likes',
    'lifetime_snapshot_followers_count',
    'lifetime_snapshot_followers_by_country',
    'lifetime_snapshot_followers_by_gender',
    'lifetime_snapshot_followers_online',
    'net_follower_growth',
    'impressions',
    'profile_views_total',
    'video_views_total',
    'comments_count_total',
    'shares_count_total',
    'likes_total',
    'posts_sent_count',
    'posts_sent_by_post_type',
    ]) }} as _airbyte_tiktok_profile_analytics_hashid
from {{ ref('tiktok_profile_analytics_ab1') }}
