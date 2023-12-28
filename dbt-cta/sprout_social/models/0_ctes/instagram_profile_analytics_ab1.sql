
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'instagram_profile_analytics') }}

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
   {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_by_country'], ['lifetime_snapshot.followers_by_country']) }} as lifetime_snapshot_followers_by_country,
   {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_by_age_gender'], ['lifetime_snapshot.followers_by_age_gender']) }} as lifetime_snapshot_followers_by_age_gender,
   {{ json_extract_scalar('metrics', ['lifetime_snapshot.followers_by_city'], ['lifetime_snapshot.followers_by_city']) }} as lifetime_snapshot_followers_by_city,
   {{ json_extract_scalar('metrics', ['lifetime_snapshot.following_count'], ['lifetime_snapshot.following_count']) }} as lifetime_snapshot_following_count,
   {{ json_extract_scalar('metrics', ['net_follower_growth'], ['net_follower_growth']) }} as net_follower_growth,
   {{ json_extract_scalar('metrics', ['followers_gained'], ['followers_gained']) }} as followers_gained,
   {{ json_extract_scalar('metrics', ['followers_lost'], ['followers_lost']) }} as followers_lost,
   {{ json_extract_scalar('metrics', ['impressions'], ['impressions']) }} as impressions,
   {{ json_extract_scalar('metrics', ['impressions_unique'], ['impressions_unique']) }} as impressions_unique,
   {{ json_extract_scalar('metrics', ['profile_views_unique'], ['profile_views_unique']) }} as profile_views_unique,
   {{ json_extract_scalar('metrics', ['video_views'], ['video_views']) }} as video_views,
   {{ json_extract_scalar('metrics', ['reactions'], ['reactions']) }} as reactions,
   {{ json_extract_scalar('metrics', ['comments_count'], ['comments_count']) }} as comments_count,
   {{ json_extract_scalar('metrics', ['shares_count'], ['shares_count']) }} as shares_count,
   {{ json_extract_scalar('metrics', ['likes'], ['likes']) }} as likes,
   {{ json_extract_scalar('metrics', ['saves'], ['saves']) }} as saves,
   {{ json_extract_scalar('metrics', ['story_replies'], ['story_replies']) }} as story_replies,
   {{ json_extract_scalar('metrics', ['email_contacts'], ['email_contacts']) }} as email_contacts,
   {{ json_extract_scalar('metrics', ['get_directions_clicks'], ['get_directions_clicks']) }} as get_directions_clicks,
   {{ json_extract_scalar('metrics', ['phone_call_clicks'], ['phone_call_clicks']) }} as phone_call_clicks,
   {{ json_extract_scalar('metrics', ['text_message_clicks'], ['text_message_clicks']) }} as text_message_clicks,
   {{ json_extract_scalar('metrics', ['website_clicks'], ['website_clicks']) }} as website_clicks,
   {{ json_extract_scalar('metrics', ['posts_sent_count'], ['posts_sent_count']) }} as posts_sent_count,
   {{ json_extract_scalar('metrics', ['posts_sent_by_post_type'], ['posts_sent_by_post_type']) }} as posts_sent_by_post_type,
   {{ json_extract_scalar('metrics', ['posts_sent_by_content_type'], ['posts_sent_by_content_type']) }} as posts_sent_by_content_type
from {{ source('cta', 'instagram_profile_analytics') }}