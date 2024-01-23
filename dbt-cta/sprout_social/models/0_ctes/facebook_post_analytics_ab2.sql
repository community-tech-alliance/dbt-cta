{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('facebook_post_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
     'created_time',
    'perma_link',
    'text',
    'sent',
    'lifetime_impressions',
    'lifetime_impressions_viral',
    'lifetime_impressions_nonviral',
    'lifetime_impressions_paid',
    'lifetime_impressions_follower',
    'lifetime_impressions_follower_organic',
    'lifetime_impressions_follower_paid',
    'lifetime_impressions_nonfollower',
    'lifetime_impressions_nonfollower_organic',
    'lifetime_impressions_nonfollower_paid',
    'lifetime_impressions_unique',
    'lifetime_impressions_organic_unique',
    'lifetime_impressions_viral_unique',
    'lifetime_impressions_nonviral_unique',
    'lifetime_impressions_paid_unique',
    'lifetime_impressions_follower_unique',
    'lifetime_impressions_follower_paid_unique',
    'lifetime_likes',
    'lifetime_reactions_love',
    'lifetime_reactions_haha',
    'lifetime_reactions_wow',
    'lifetime_reactions_sad',
    'lifetime_reactions_angry',
    'lifetime_shares_count',
    'lifetime_question_answers',
    'lifetime_post_content_clicks',
    'lifetime_post_photo_view_clicks',
    'lifetime_post_video_play_clicks',
    'lifetime_post_content_clicks_other',
    'lifetime_negative_feedback',
    'lifetime_engagements_unique',
    'lifetime_engagements_follower_unique',
    'lifetime_reactions_unique',
    'lifetime_comments_count_unique',
    'lifetime_shares_count_unique',
    'lifetime_question_answers_unique',
    'lifetime_post_link_clicks_unique',
    'lifetime_post_content_clicks_unique',
    'lifetime_post_photo_view_clicks_unique',
    'lifetime_post_video_play_clicks_unique',
    'lifetime_post_other_clicks_unique',
    'lifetime_negative_feedback_unique',
    'video_length',
    'lifetime_video_views',
    'lifetime_video_views_unique',
    'lifetime_video_views_organic',
    'lifetime_video_views_organic_unique',
    'lifetime_video_views_paid',
    'lifetime_video_views_paid_unique',
    'lifetime_video_views_autoplay',
    'lifetime_video_views_click_to_play',
    'lifetime_video_views_sound_on',
    'lifetime_video_views_sound_off',
    'lifetime_video_views_10s',
    'lifetime_video_views_10s_organic',
    'lifetime_video_views_10s_paid',
    'lifetime_video_views_10s_autoplay',
    'lifetime_video_views_10s_click_to_play',
    'lifetime_video_views_10s_sound_on',
    'lifetime_video_views_10s_sound_off',
    'lifetime_video_views_partial',
    'lifetime_video_views_partial_organic',
    'lifetime_video_views_partial_paid',
    'lifetime_video_views_partial_autoplay',
    'lifetime_video_views_partial_click_to_play',
    'lifetime_video_views_30s_complete',
    'lifetime_video_views_30s_complete_organic',
    'lifetime_video_views_30s_complete_paid',
    'lifetime_video_views_30s_complete_autoplay',
    'lifetime_video_views_30s_complete_click_to_play',
    'lifetime_video_views_p95',
    'lifetime_video_views_p95_organic',
    'lifetime_video_views_p95_paid',
    'lifetime_video_views_10s_unique',
    'lifetime_video_views_30s_complete_unique',
    'lifetime_video_views_p95_paid_unique',
    'lifetime_video_views_p95_organic_unique',
    'lifetime_video_view_time_per_view',
    'lifetime_video_view_time',
    'lifetime_video_view_time_organic',
    'lifetime_video_view_time_paid',
    'lifetime_video_ad_break_impressions',
    'lifetime_video_ad_break_earnings',
    'lifetime_video_ad_break_cost_per_impression',
    ]) }} as _airbyte_facebook_post_analytics_hashid
from {{ ref('facebook_post_analytics_ab1') }}