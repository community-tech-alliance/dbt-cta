{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tiktok_post_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
     'created_time',
    'perma_link',
    'text',
    'sent',
    'lifetime_likes',
    'lifetime_reactions',
    'lifetime_shares_count',
    'lifetime_comments_count',
    'lifetime_video_view_time_per_view',
    'lifetime_video_views_p100_per_view',
    'lifetime_impression_source_follow',
    'lifetime_impression_source_for_you',
    'lifetime_impression_source_hashtag',
    'lifetime_impression_source_personal_profile',
    'lifetime_impression_source_sound',
    'lifetime_impression_source_unspecified',
    'lifetime_video_view_time',
    'lifetime_video_views',
    'lifetime_impressions_unique',
    'lifetime_impressions',
    'video_length'    
    ]) }} as _airbyte_tiktok_post_analytics_hashid
from {{ ref('tiktok_post_analytics_ab1') }}
