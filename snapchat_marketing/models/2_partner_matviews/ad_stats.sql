{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_stats_daily_hashid'
) }}

select
     _airbyte_ads_stats_daily_hashid
    ,id
    ,type
    ,saves
    ,spend
    ,shares
    ,swipe_ups
    ,uniques
    ,end_time
    ,frequency
    ,quartile_1
    ,quartile_2
    ,quartile_3
    ,start_time
    ,granularity
    ,impressions
    ,total_reach
    ,video_views
    ,earned_reach
    ,ios_installs
    ,native_leads
    ,custom_event_1
    ,custom_event_2
    ,custom_event_3
    ,custom_event_4
    ,custom_event_5
    ,total_installs
    ,conversion_rate
    ,conversion_save
    ,video_views_15s
    ,view_completion
    ,android_installs
    ,conversion_login
    ,conversion_share
    ,paid_impressions
    ,play_time_millis
    ,swipe_up_percent
    ,view_time_millis
    ,conversion_invite
    ,total_impressions
    ,attachment_uniques
    ,conversion_ad_view
    ,conversion_reserve
    ,earned_impressions
    ,screen_time_millis
    ,conversion_ad_click
    ,conversion_add_cart
    ,conversion_searches
    ,attachment_frequency
    ,avg_view_time_millis
    ,conversion_app_opens
    ,conversion_list_view
    ,conversion_purchases
    ,conversion_subscribe
    ,attachment_quartile_1
    ,attachment_quartile_2
    ,attachment_quartile_3
    ,conversion_page_views
    ,attachment_impressions
    ,avg_screen_time_millis
    ,conversion_add_billing
    ,conversion_start_trial
    ,video_views_time_based
    ,conversion_view_content
    ,conversion_spend_credits
    ,conversion_start_checkout
    ,attachment_view_completion
    ,conversion_add_to_wishlist
    ,conversion_level_completes
    ,conversion_purchases_value
    ,conversion_complete_tutorial
    ,attachment_avg_view_time_millis
    ,conversion_achievement_unlocked
    ,attachment_total_view_time_millis
    ,_airbyte_ab_id
    ,_airbyte_emitted_at
    ,_airbyte_normalized_at
FROM {{ source('cta', 'ad_stats_base') }}
GROUP BY _airbyte_ads_stats_daily_hashid