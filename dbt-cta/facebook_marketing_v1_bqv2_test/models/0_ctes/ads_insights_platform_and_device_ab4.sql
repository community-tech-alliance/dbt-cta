{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_insights_platform_and_device_hashid'
) }}

-- depends_on: {{ ref('ads_insights_platform_and_device_ab3') }}, {{ ref('ads_insights_platform_and_device_cost_per_thruplay_ab2') }} ,{{ ref('ads_insights_platform_and_device_cost_per_2_sec_continuous_video_view_ab2') }} ,{{ ref('ads_insights_platform_and_device_cost_per_15_sec_video_view_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_15_sec_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_30_sec_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_p25_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_p50_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_p75_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_p95_watched_actions_ab2') }} ,{{ ref('ads_insights_platform_and_device_video_p100_watched_actions_ab2') }}, {{ ref('ads_insights_platform_and_device_website_ctr_ab2') }}, {{ ref('ads_insights_platform_and_device_actions_ab2') }}, {{ ref('ads_insights_platform_and_device_video_play_actions_ab2') }}
select
    insights._airbyte_ads_insights_platform_and_device_hashid,
    insights._airbyte_extracted_at,
    insights._airbyte_raw_id,
    insights.ad_id,
    insights.date_start,
    insights.date_stop,
    --PLATFORM AND DEVICE
    insights.publisher_platform,
    insights.platform_position,
    insights.impression_device,
    --METRICS
    insights.cpc,
    insights.cpm,
    insights.cpp,
    insights.ctr,
    insights.reach,
    insights.spend,
    insights.clicks,
    insights.labels,
    insights.ad_name,
    insights.adset_id,
    insights.location,
    insights.wish_bid,
    insights.frequency,
    insights.objective,
    insights.account_id,
    insights.adset_name,
    insights.unique_ctr,
    insights.auction_bid,
    insights.buying_type,
    insights.campaign_id,
    insights.impressions,
    insights.account_name,
    insights.created_time,
    insights.social_spend,
    insights.updated_time,
    insights.age_targeting,
    insights.campaign_name,
    insights.unique_clicks,
    insights.full_view_reach,
    insights.quality_ranking,
    insights.account_currency,
    insights.gender_targeting,
    insights.optimization_goal,
    insights.inline_link_clicks,
    insights.attribution_setting,
    insights.canvas_avg_view_time,
    insights.cost_per_unique_click,
    insights.full_view_impressions,
    insights.inline_link_click_ctr,
    insights.estimated_ad_recallers,
    insights.inline_post_engagement,
    insights.unique_link_clicks_ctr,
    insights.auction_competitiveness,
    insights.canvas_avg_view_percent,
    insights.conversion_rate_ranking,
    insights.engagement_rate_ranking,
    insights.estimated_ad_recall_rate,
    insights.unique_inline_link_clicks,
    insights.auction_max_competitor_bid,
    insights.cost_per_inline_link_click,
    insights.unique_inline_link_click_ctr,
    insights.cost_per_estimated_ad_recallers,
    insights.cost_per_inline_post_engagement,
    insights.cost_per_unique_inline_link_click,
    insights.instant_experience_clicks_to_open,
    insights.estimated_ad_recallers_lower_bound,
    insights.estimated_ad_recallers_upper_bound,
    insights.instant_experience_clicks_to_start,
    insights.estimated_ad_recall_rate_lower_bound,
    insights.estimated_ad_recall_rate_upper_bound,
    insights.qualifying_question_qualify_answer_rate,
    --VIDEO METRICS
    video_played.value as video_played,
    video_continuous_2_sec_watched.value as video_continuous_2_sec_watched_actions,
    cost_per_2_sec_continuous_video_view.value as cost_per_2_sec_continuous_video_view,
    video_15_sec_watched.value as video_15_sec_watched_actions,
    cost_per_15_sec_video_view.value as cost_per_15_sec_video_view,
    video_30_sec_watched.value as video_30_sec_watched_actions,
    cost_per_thruplay.value as cost_per_thruplay,
    video_p25_watched.value as video_p25_watched,
    video_p50_watched.value as video_p50_watched,
    video_p75_watched.value as video_p75_watched,
    video_p95_watched.value as video_p95_watched,
    video_p100_watched.value as video_p100_watched,
    website_ctr.value as website_ctr,
    landing_page_views.value as landing_page_views,
    shares.value as shares,
    conversion_values.value as conversion_values
from {{ ref('ads_insights_platform_and_device_ab3') }} as insights
left join {{ ref('ads_insights_platform_and_device_cost_per_thruplay_ab2') }} as cost_per_thruplay
    on insights._airbyte_ads_insights_platform_and_device_hashid = cost_per_thruplay._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_continuous_2_sec_watched_actions_ab2') }} as video_continuous_2_sec_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_continuous_2_sec_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_cost_per_2_sec_continuous_video_view_ab2') }} as cost_per_2_sec_continuous_video_view
    on insights._airbyte_ads_insights_platform_and_device_hashid = cost_per_2_sec_continuous_video_view._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_cost_per_15_sec_video_view_ab2') }} as cost_per_15_sec_video_view
    on insights._airbyte_ads_insights_platform_and_device_hashid = cost_per_15_sec_video_view._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_15_sec_watched_actions_ab2') }} as video_15_sec_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_15_sec_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_30_sec_watched_actions_ab2') }} as video_30_sec_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_30_sec_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_p25_watched_actions_ab2') }} as video_p25_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_p25_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_p50_watched_actions_ab2') }} as video_p50_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_p50_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_p75_watched_actions_ab2') }} as video_p75_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_p75_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_p95_watched_actions_ab2') }} as video_p95_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_p95_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_p100_watched_actions_ab2') }} as video_p100_watched
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_p100_watched._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_website_ctr_ab2') }} as website_ctr
    on insights._airbyte_ads_insights_platform_and_device_hashid = website_ctr._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_video_play_actions_ab2') }} as video_played
    on insights._airbyte_ads_insights_platform_and_device_hashid = video_played._airbyte_ads_insights_platform_and_device_hashid
left join {{ ref('ads_insights_platform_and_device_actions_ab2') }} as landing_page_views
    on
        insights._airbyte_ads_insights_platform_and_device_hashid = landing_page_views._airbyte_ads_insights_platform_and_device_hashid
        and landing_page_views.action_type = 'landing_page_view'
left join {{ ref('ads_insights_platform_and_device_actions_ab2') }} as shares
    on
        insights._airbyte_ads_insights_platform_and_device_hashid = landing_page_views._airbyte_ads_insights_platform_and_device_hashid
        and landing_page_views.action_type = 'post'
left join {{ ref('ads_insights_platform_and_device_conversion_values_ab2') }} as conversion_values
    on insights._airbyte_ads_insights_platform_and_device_hashid = conversion_values._airbyte_ads_insights_platform_and_device_hashid
