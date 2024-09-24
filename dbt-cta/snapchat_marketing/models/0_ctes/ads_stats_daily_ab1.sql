{% set raw_table = env_var("CTA_DATASET_ID") ~ "_raw__stream_ads_stats_daily" %}

{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}

-- depends_on: {{ source('cta_raw', raw_table) }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['saves'], ['saves']) }} as saves,
    {{ json_extract_scalar('_airbyte_data', ['spend'], ['spend']) }} as spend,
    {{ json_extract_scalar('_airbyte_data', ['shares'], ['shares']) }} as shares,
    {{ json_extract_scalar('_airbyte_data', ['swipes'], ['swipes']) }} as swipes,
    {{ json_extract_scalar('_airbyte_data', ['uniques'], ['uniques']) }} as uniques,
    {{ json_extract_scalar('_airbyte_data', ['end_time'], ['end_time']) }} as end_time,
    {{ json_extract_scalar('_airbyte_data', ['frequency'], ['frequency']) }} as frequency,
    {{ json_extract_scalar('_airbyte_data', ['quartile_1'], ['quartile_1']) }} as quartile_1,
    {{ json_extract_scalar('_airbyte_data', ['quartile_2'], ['quartile_2']) }} as quartile_2,
    {{ json_extract_scalar('_airbyte_data', ['quartile_3'], ['quartile_3']) }} as quartile_3,
    {{ json_extract_scalar('_airbyte_data', ['start_time'], ['start_time']) }} as start_time,
    {{ json_extract_scalar('_airbyte_data', ['granularity'], ['granularity']) }} as granularity,
    {{ json_extract_scalar('_airbyte_data', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_scalar('_airbyte_data', ['total_reach'], ['total_reach']) }} as total_reach,
    {{ json_extract_scalar('_airbyte_data', ['video_views'], ['video_views']) }} as video_views,
    {{ json_extract_scalar('_airbyte_data', ['earned_reach'], ['earned_reach']) }} as earned_reach,
    {{ json_extract_scalar('_airbyte_data', ['ios_installs'], ['ios_installs']) }} as ios_installs,
    {{ json_extract_scalar('_airbyte_data', ['native_leads'], ['native_leads']) }} as native_leads,
    {{ json_extract_scalar('_airbyte_data', ['custom_event_1'], ['custom_event_1']) }} as custom_event_1,
    {{ json_extract_scalar('_airbyte_data', ['custom_event_2'], ['custom_event_2']) }} as custom_event_2,
    {{ json_extract_scalar('_airbyte_data', ['custom_event_3'], ['custom_event_3']) }} as custom_event_3,
    {{ json_extract_scalar('_airbyte_data', ['custom_event_4'], ['custom_event_4']) }} as custom_event_4,
    {{ json_extract_scalar('_airbyte_data', ['custom_event_5'], ['custom_event_5']) }} as custom_event_5,
    {{ json_extract_scalar('_airbyte_data', ['total_installs'], ['total_installs']) }} as total_installs,
    {{ json_extract_scalar('_airbyte_data', ['conversion_rate'], ['conversion_rate']) }} as conversion_rate,
    {{ json_extract_scalar('_airbyte_data', ['conversion_save'], ['conversion_save']) }} as conversion_save,
    {{ json_extract_scalar('_airbyte_data', ['video_views_15s'], ['video_views_15s']) }} as video_views_15s,
    {{ json_extract_scalar('_airbyte_data', ['view_completion'], ['view_completion']) }} as view_completion,
    {{ json_extract_scalar('_airbyte_data', ['android_installs'], ['android_installs']) }} as android_installs,
    {{ json_extract_scalar('_airbyte_data', ['conversion_login'], ['conversion_login']) }} as conversion_login,
    {{ json_extract_scalar('_airbyte_data', ['conversion_share'], ['conversion_share']) }} as conversion_share,
    {{ json_extract_scalar('_airbyte_data', ['paid_impressions'], ['paid_impressions']) }} as paid_impressions,
    {{ json_extract_scalar('_airbyte_data', ['play_time_millis'], ['play_time_millis']) }} as play_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['swipe_up_percent'], ['swipe_up_percent']) }} as swipe_up_percent,
    {{ json_extract_scalar('_airbyte_data', ['view_time_millis'], ['view_time_millis']) }} as view_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['conversion_invite'], ['conversion_invite']) }} as conversion_invite,
    {{ json_extract_scalar('_airbyte_data', ['total_impressions'], ['total_impressions']) }} as total_impressions,
    {{ json_extract_scalar('_airbyte_data', ['attachment_uniques'], ['attachment_uniques']) }} as attachment_uniques,
    {{ json_extract_scalar('_airbyte_data', ['conversion_ad_view'], ['conversion_ad_view']) }} as conversion_ad_view,
    {{ json_extract_scalar('_airbyte_data', ['conversion_reserve'], ['conversion_reserve']) }} as conversion_reserve,
    {{ json_extract_scalar('_airbyte_data', ['earned_impressions'], ['earned_impressions']) }} as earned_impressions,
    {{ json_extract_scalar('_airbyte_data', ['screen_time_millis'], ['screen_time_millis']) }} as screen_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['conversion_ad_click'], ['conversion_ad_click']) }} as conversion_ad_click,
    {{ json_extract_scalar('_airbyte_data', ['conversion_add_cart'], ['conversion_add_cart']) }} as conversion_add_cart,
    {{ json_extract_scalar('_airbyte_data', ['conversion_searches'], ['conversion_searches']) }} as conversion_searches,
    {{ json_extract_scalar('_airbyte_data', ['attachment_frequency'], ['attachment_frequency']) }} as attachment_frequency,
    {{ json_extract_scalar('_airbyte_data', ['avg_view_time_millis'], ['avg_view_time_millis']) }} as avg_view_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['conversion_app_opens'], ['conversion_app_opens']) }} as conversion_app_opens,
    {{ json_extract_scalar('_airbyte_data', ['conversion_list_view'], ['conversion_list_view']) }} as conversion_list_view,
    {{ json_extract_scalar('_airbyte_data', ['conversion_purchases'], ['conversion_purchases']) }} as conversion_purchases,
    {{ json_extract_scalar('_airbyte_data', ['conversion_subscribe'], ['conversion_subscribe']) }} as conversion_subscribe,
    {{ json_extract_scalar('_airbyte_data', ['attachment_quartile_1'], ['attachment_quartile_1']) }} as attachment_quartile_1,
    {{ json_extract_scalar('_airbyte_data', ['attachment_quartile_2'], ['attachment_quartile_2']) }} as attachment_quartile_2,
    {{ json_extract_scalar('_airbyte_data', ['attachment_quartile_3'], ['attachment_quartile_3']) }} as attachment_quartile_3,
    {{ json_extract_scalar('_airbyte_data', ['conversion_page_views'], ['conversion_page_views']) }} as conversion_page_views,
    {{ json_extract_scalar('_airbyte_data', ['attachment_impressions'], ['attachment_impressions']) }} as attachment_impressions,
    {{ json_extract_scalar('_airbyte_data', ['avg_screen_time_millis'], ['avg_screen_time_millis']) }} as avg_screen_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['conversion_add_billing'], ['conversion_add_billing']) }} as conversion_add_billing,
    {{ json_extract_scalar('_airbyte_data', ['conversion_start_trial'], ['conversion_start_trial']) }} as conversion_start_trial,
    {{ json_extract_scalar('_airbyte_data', ['video_views_time_based'], ['video_views_time_based']) }} as video_views_time_based,
    {{ json_extract_scalar('_airbyte_data', ['conversion_view_content'], ['conversion_view_content']) }} as conversion_view_content,
    {{ json_extract_scalar('_airbyte_data', ['conversion_spend_credits'], ['conversion_spend_credits']) }} as conversion_spend_credits,
    {{ json_extract_scalar('_airbyte_data', ['conversion_start_checkout'], ['conversion_start_checkout']) }} as conversion_start_checkout,
    {{ json_extract_scalar('_airbyte_data', ['attachment_view_completion'], ['attachment_view_completion']) }} as attachment_view_completion,
    {{ json_extract_scalar('_airbyte_data', ['conversion_add_to_wishlist'], ['conversion_add_to_wishlist']) }} as conversion_add_to_wishlist,
    {{ json_extract_scalar('_airbyte_data', ['conversion_level_completes'], ['conversion_level_completes']) }} as conversion_level_completes,
    {{ json_extract_scalar('_airbyte_data', ['conversion_purchases_value'], ['conversion_purchases_value']) }} as conversion_purchases_value,
    {{ json_extract_scalar('_airbyte_data', ['conversion_complete_tutorial'], ['conversion_complete_tutorial']) }} as conversion_complete_tutorial,
    {{ json_extract_scalar('_airbyte_data', ['attachment_avg_view_time_millis'], ['attachment_avg_view_time_millis']) }} as attachment_avg_view_time_millis,
    {{ json_extract_scalar('_airbyte_data', ['conversion_achievement_unlocked'], ['conversion_achievement_unlocked']) }} as conversion_achievement_unlocked,
    {{ json_extract_scalar('_airbyte_data', ['attachment_total_view_time_millis'], ['attachment_total_view_time_millis']) }} as attachment_total_view_time_millis,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta_raw', raw_table) }}
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}
