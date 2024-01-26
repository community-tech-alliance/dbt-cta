{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'facebook_profile_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    dimensions,
    -- dimensions fields unnested:
    {{ json_extract_scalar('dimensions', ['customer_profile_id'], ['customer_profile_id']) }} as customer_profile_id,
    {{ json_extract_scalar('dimensions', ['reporting_period.by(day)'], ['reporting_period.by(day)']) }} as reporting_period_day,
    metrics,
    -- metrics fields unnested:
    {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_count'], ['lifetime_snapshot.followers_count']) }} as lifetime_snapshot_followers_count,
    json_extract(metrics, "$['lifetime_snapshot.followers_by_country']") as followers_by_country,
    json_extract(metrics, "$['lifetime_snapshot.followers_by_age_gender']") as followers_by_age_gender,
    json_extract(metrics, "$['lifetime_snapshot.followers_by_city']") as followers_by_city,
    {{ json_extract_scalar('metrics', ['net_follower_growth'], ['net_follower_growth']) }} as net_follower_growth,
    {{ json_extract_scalar('metrics', ['followers_gained'], ['followers_gained']) }} as followers_gained,
    {{ json_extract_scalar('metrics', ['followers_gained_organic'], ['followers_gained_organic']) }} as followers_gained_organic,
    {{ json_extract_scalar('metrics', ['followers_gained_paid'], ['followers_gained_paid']) }} as followers_gained_paid,
    {{ json_extract_scalar('metrics', ['followers_lost'], ['followers_lost']) }} as followers_lost,
    {{ json_extract_scalar('metrics', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_scalar('metrics', ['impressions_organic'], ['impressions_organic']) }} as impressions_organic,
    {{ json_extract_scalar('metrics', ['impressions_viral'], ['impressions_viral']) }} as impressions_viral,
    {{ json_extract_scalar('metrics', ['impressions_nonviral'], ['impressions_nonviral']) }} as impressions_nonviral,
    {{ json_extract_scalar('metrics', ['impressions_paid'], ['impressions_paid']) }} as impressions_paid,
    {{ json_extract_scalar('metrics', ['tab_views'], ['tab_views']) }} as tab_views,
    {{ json_extract_scalar('metrics', ['tab_views_login'], ['tab_views_login']) }} as tab_views_login,
    {{ json_extract_scalar('metrics', ['tab_views_logout'], ['tab_views_logout']) }} as tab_views_logout,
    {{ json_extract_scalar('metrics', ['post_impressions'], ['post_impressions']) }} as post_impressions,
    {{ json_extract_scalar('metrics', ['post_impressions_organic'], ['post_impressions_organic']) }} as post_impressions_organic,
    {{ json_extract_scalar('metrics', ['post_impressions_viral'], ['post_impressions_viral']) }} as post_impressions_viral,
    {{ json_extract_scalar('metrics', ['post_impressions_nonviral'], ['post_impressions_nonviral']) }} as post_impressions_nonviral,
    {{ json_extract_scalar('metrics', ['post_impressions_paid'], ['post_impressions_paid']) }} as post_impressions_paid,
    {{ json_extract_scalar('metrics', ['impressions_unique'], ['impressions_unique']) }} as impressions_unique,
    {{ json_extract_scalar('metrics', ['impressions_organic_unique'], ['impressions_organic_unique']) }} as impressions_organic_unique,
    {{ json_extract_scalar('metrics', ['impressions_viral_unique'], ['impressions_viral_unique']) }} as impressions_viral_unique,
    {{ json_extract_scalar('metrics', ['impressions_nonviral_unique'], ['impressions_nonviral_unique']) }} as impressions_nonviral_unique,
    {{ json_extract_scalar('metrics', ['impressions_paid_unique'], ['impressions_paid_unique']) }} as impressions_paid_unique,
    {{ json_extract_scalar('metrics', ['profile_views'], ['profile_views']) }} as profile_views,
    {{ json_extract_scalar('metrics', ['profile_views_login'], ['profile_views_login']) }} as profile_views_login,
    {{ json_extract_scalar('metrics', ['profile_views_logout'], ['profile_views_logout']) }} as profile_views_logout,
    {{ json_extract_scalar('metrics', ['profile_views_login_unique'], ['profile_views_login_unique']) }} as profile_views_login_unique,
    {{ json_extract_scalar('metrics', ['reactions'], ['reactions']) }} as reactions,
    {{ json_extract_scalar('metrics', ['comments_count'], ['comments_count']) }} as comments_count,
    {{ json_extract_scalar('metrics', ['shares_count'], ['shares_count']) }} as shares_count,
    {{ json_extract_scalar('metrics', ['post_link_clicks'], ['post_link_clicks']) }} as post_link_clicks,
    {{ json_extract_scalar('metrics', ['post_content_clicks_other'], ['post_content_clicks_other']) }} as post_content_clicks_other,
    {{ json_extract_scalar('metrics', ['likes'], ['likes']) }} as likes,
    {{ json_extract_scalar('metrics', ['reactions_love'], ['reactions_love']) }} as reactions_love,
    {{ json_extract_scalar('metrics', ['reactions_haha'], ['reactions_haha']) }} as reactions_haha,
    {{ json_extract_scalar('metrics', ['reactions_wow'], ['reactions_wow']) }} as reactions_wow,
    {{ json_extract_scalar('metrics', ['reactions_sad'], ['reactions_sad']) }} as reactions_sad,
    {{ json_extract_scalar('metrics', ['reactions_angry'], ['reactions_angry']) }} as reactions_angry,
    {{ json_extract_scalar('metrics', ['post_photo_view_clicks'], ['post_photo_view_clicks']) }} as post_photo_view_clicks,
    {{ json_extract_scalar('metrics', ['post_video_play_clicks'], ['post_video_play_clicks']) }} as post_video_play_clicks,
    {{ json_extract_scalar('metrics', ['profile_actions'], ['profile_actions']) }} as profile_actions,
    {{ json_extract_scalar('metrics', ['post_engagements'], ['post_engagements']) }} as post_engagements,
    {{ json_extract_scalar('metrics', ['cta_clicks_login'], ['cta_clicks_login']) }} as cta_clicks_login,
    {{ json_extract_scalar('metrics', ['question_answers'], ['question_answers']) }} as question_answers,
    {{ json_extract_scalar('metrics', ['offer_claims'], ['offer_claims']) }} as offer_claims,
    {{ json_extract_scalar('metrics', ['positive_feedback_other'], ['positive_feedback_other']) }} as positive_feedback_other,
    {{ json_extract_scalar('metrics', ['event_rsvps'], ['event_rsvps']) }} as event_rsvps,
    {{ json_extract_scalar('metrics', ['place_checkins'], ['place_checkins']) }} as place_checkins,
    {{ json_extract_scalar('metrics', ['place_checkins_mobile'], ['place_checkins_mobile']) }} as place_checkins_mobile,
    {{ json_extract_scalar('metrics', ['profile_content_activity'], ['profile_content_activity']) }} as profile_content_activity,
    {{ json_extract_scalar('metrics', ['negative_feedback'], ['negative_feedback']) }} as negative_feedback,
    {{ json_extract_scalar('metrics', ['video_views'], ['video_views']) }} as video_views,
    {{ json_extract_scalar('metrics', ['video_views_organic'], ['video_views_organic']) }} as video_views_organic,
    {{ json_extract_scalar('metrics', ['video_views_paid'], ['video_views_paid']) }} as video_views_paid,
    {{ json_extract_scalar('metrics', ['video_views_autoplay'], ['video_views_autoplay']) }} as video_views_autoplay,
    {{ json_extract_scalar('metrics', ['video_views_click_to_play'], ['video_views_click_to_play']) }} as video_views_click_to_play,
    {{ json_extract_scalar('metrics', ['video_views_repeat'], ['video_views_repeat']) }} as video_views_repeat,
    {{ json_extract_scalar('metrics', ['video_view_time'], ['video_view_time']) }} as video_view_time,
    {{ json_extract_scalar('metrics', ['video_views_unique'], ['video_views_unique']) }} as video_views_unique,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete'], ['video_views_30s_complete']) }} as video_views_30s_complete,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_organic'], ['video_views_30s_complete_organic']) }} as video_views_30s_complete_organic,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_paid'], ['video_views_30s_complete_paid']) }} as video_views_30s_complete_paid,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_autoplay'], ['video_views_30s_complete_autoplay']) }} as video_views_30s_complete_autoplay,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_click_to_play'], ['video_views_30s_complete_click_to_play']) }} as video_views_30s_complete_click_to_play,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_unique'], ['video_views_30s_complete_unique']) }} as video_views_30s_complete_unique,
    {{ json_extract_scalar('metrics', ['video_views_30s_complete_repeat'], ['video_views_30s_complete_repeat']) }} as video_views_30s_complete_repeat,
    {{ json_extract_scalar('metrics', ['video_views_partial'], ['video_views_partial']) }} as video_views_partial,
    {{ json_extract_scalar('metrics', ['video_views_partial_organic'], ['video_views_partial_organic']) }} as video_views_partial_organic,
    {{ json_extract_scalar('metrics', ['video_views_partial_paid'], ['video_views_partial_paid']) }} as video_views_partial_paid,
    {{ json_extract_scalar('metrics', ['video_views_partial_autoplay'], ['video_views_partial_autoplay']) }} as video_views_partial_autoplay,
    {{ json_extract_scalar('metrics', ['video_views_partial_click_to_play'], ['video_views_partial_click_to_play']) }} as video_views_partial_click_to_play,
    {{ json_extract_scalar('metrics', ['video_views_partial_repeat'], ['video_views_partial_repeat']) }} as video_views_partial_repeat,
    {{ json_extract_scalar('metrics', ['video_views_10s'], ['video_views_10s']) }} as video_views_10s,
    {{ json_extract_scalar('metrics', ['video_views_10s_organic'], ['video_views_10s_organic']) }} as video_views_10s_organic,
    {{ json_extract_scalar('metrics', ['video_views_10s_paid'], ['video_views_10s_paid']) }} as video_views_10s_paid,
    {{ json_extract_scalar('metrics', ['video_views_10s_autoplay'], ['video_views_10s_autoplay']) }} as video_views_10s_autoplay,
    {{ json_extract_scalar('metrics', ['video_views_10s_click_to_play'], ['video_views_10s_click_to_play']) }} as video_views_10s_click_to_play,
    {{ json_extract_scalar('metrics', ['video_views_10s_repeat'], ['video_views_10s_repeat']) }} as video_views_10s_repeat,
    {{ json_extract_scalar('metrics', ['video_views_10s_unique'], ['video_views_10s_unique']) }} as video_views_10s_unique,
    {{ json_extract_scalar('metrics', ['posts_sent_count'], ['posts_sent_count']) }} as posts_sent_count,
    json_extract(metrics, '$.posts_sent_by_post_type') as posts_sent_by_post_type,
    json_extract(metrics, '$.posts_sent_by_content_type') as posts_sent_by_content_type
from {{ source('cta', 'facebook_profile_analytics') }}
