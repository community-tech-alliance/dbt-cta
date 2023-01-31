{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_stats_daily_hashid'
) }}

select
     _airbyte_ads_stats_daily_hashid
    ,MAX(id) as id
    ,MAX(type) as type
    ,MAX(saves) as saves
    ,MAX(spend) as spend
    ,MAX(shares) as shares
    ,MAX(swipe_ups) as swipe_ups
    ,MAX(uniques) as uniques
    ,MAX(end_time) as end_time
    ,MAX(frequency) as frequency
    ,MAX(quartile_1) as quartile_1
    ,MAX(quartile_2) as quartile_2
    ,MAX(quartile_3) as quartile_3
    ,MAX(start_time) as start_time
    ,MAX(granularity) as granularity
    ,MAX(impressions) as impressions
    ,MAX(total_reach) as total_reach
    ,MAX(video_views) as video_views
    ,MAX(earned_reach) as earned_reach
    ,MAX(ios_installs) as ios_installs
    ,MAX(native_leads) as native_leads
    ,MAX(custom_event_1) as custom_event_1
    ,MAX(custom_event_2) as custom_event_2
    ,MAX(custom_event_3) as custom_event_3
    ,MAX(custom_event_4) as custom_event_4
    ,MAX(custom_event_5) as custom_event_5
    ,MAX(total_installs) as total_installs
    ,MAX(conversion_rate) as conversion_rate
    ,MAX(conversion_save) as conversion_save
    ,MAX(video_views_15s) as video_views_15s
    ,MAX(view_completion) as view_completion
    ,MAX(android_installs) as android_installs
    ,MAX(conversion_login) as conversion_login
    ,MAX(conversion_share) as conversion_share
    ,MAX(paid_impressions) as paid_impressions
    ,MAX(play_time_millis) as play_time_millis
    ,MAX(swipe_up_percent) as swipe_up_percent
    ,MAX(view_time_millis) as view_time_millis
    ,MAX(conversion_invite) as conversion_invite
    ,MAX(total_impressions) as total_impressions
    ,MAX(attachment_uniques) as attachment_uniques
    ,MAX(conversion_ad_view) as conversion_ad_view
    ,MAX(conversion_reserve) as conversion_reserve
    ,MAX(earned_impressions) as earned_impressions
    ,MAX(screen_time_millis) as screen_time_millis
    ,MAX(conversion_ad_click) as conversion_ad_click
    ,MAX(conversion_add_cart) as conversion_add_cart
    ,MAX(conversion_searches) as conversion_searches
    ,MAX(attachment_frequency) as attachment_frequency
    ,MAX(avg_view_time_millis) as avg_view_time_millis
    ,MAX(conversion_app_opens) as conversion_app_opens
    ,MAX(conversion_list_view) as conversion_list_view
    ,MAX(conversion_purchases) as conversion_purchases
    ,MAX(conversion_subscribe) as conversion_subscribe
    ,MAX(attachment_quartile_1) as attachment_quartile_1
    ,MAX(attachment_quartile_2) as attachment_quartile_2
    ,MAX(attachment_quartile_3) as attachment_quartile_3
    ,MAX(conversion_page_views) as conversion_page_views
    ,MAX(attachment_impressions) as attachment_impressions
    ,MAX(avg_screen_time_millis) as avg_screen_time_millis
    ,MAX(conversion_add_billing) as conversion_add_billing
    ,MAX(conversion_start_trial) as conversion_start_trial
    ,MAX(video_views_time_based) as video_views_time_based
    ,MAX(conversion_view_content) as conversion_view_content
    ,MAX(conversion_spend_credits) as conversion_spend_credits
    ,MAX(conversion_start_checkout) as conversion_start_checkout
    ,MAX(attachment_view_completion) as attachment_view_completion
    ,MAX(conversion_add_to_wishlist) as conversion_add_to_wishlist
    ,MAX(conversion_level_completes) as conversion_level_completes
    ,MAX(conversion_purchases_value) as conversion_purchases_value
    ,MAX(conversion_complete_tutorial) as conversion_complete_tutorial
    ,MAX(attachment_avg_view_time_millis) as attachment_avg_view_time_millis
    ,MAX(conversion_achievement_unlocked) as conversion_achievement_unlocked
    ,MAX(attachment_total_view_time_millis) as attachment_total_view_time_millis
    ,MAX(_airbyte_ab_id) as _airbyte_ab_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'ad_stats_base') }}
WHERE timestamp(end_time) BETWEEN timestamp('2023-01-01') AND timestamp('2023-12-31')
GROUP BY _airbyte_ads_stats_daily_hashid