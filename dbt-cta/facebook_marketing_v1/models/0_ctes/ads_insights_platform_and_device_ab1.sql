{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_ads_insights_platform_and_device') }}
select
    {{ json_extract_scalar('_airbyte_data', ['cpc'], ['cpc']) }} as cpc,
    {{ json_extract_scalar('_airbyte_data', ['cpm'], ['cpm']) }} as cpm,
    {{ json_extract_scalar('_airbyte_data', ['cpp'], ['cpp']) }} as cpp,
    {{ json_extract_scalar('_airbyte_data', ['ctr'], ['ctr']) }} as ctr,
    {{ json_extract_scalar('_airbyte_data', ['ad_id'], ['ad_id']) }} as ad_id,
    {{ json_extract_scalar('_airbyte_data', ['reach'], ['reach']) }} as reach,
    {{ json_extract_scalar('_airbyte_data', ['spend'], ['spend']) }} as spend,
    {{ json_extract_scalar('_airbyte_data', ['clicks'], ['clicks']) }} as clicks,
    {{ json_extract_scalar('_airbyte_data', ['labels'], ['labels']) }} as labels,
    {{ json_extract_array('_airbyte_data', ['actions'], ['actions']) }} as actions,
    {{ json_extract_scalar('_airbyte_data', ['ad_name'], ['ad_name']) }} as ad_name,
    {{ json_extract_scalar('_airbyte_data', ['adset_id'], ['adset_id']) }} as adset_id,
    {{ json_extract_scalar('_airbyte_data', ['location'], ['location']) }} as location,
    {{ json_extract_scalar('_airbyte_data', ['wish_bid'], ['wish_bid']) }} as wish_bid,
    {{ json_extract_scalar('_airbyte_data', ['date_stop'], ['date_stop']) }} as date_stop,
    {{ json_extract_scalar('_airbyte_data', ['frequency'], ['frequency']) }} as frequency,
    {{ json_extract_scalar('_airbyte_data', ['objective'], ['objective']) }} as objective,
    {{ json_extract_scalar('_airbyte_data', ['account_id'], ['account_id']) }} as account_id,
    {{ json_extract_scalar('_airbyte_data', ['adset_name'], ['adset_name']) }} as adset_name,
    {{ json_extract_scalar('_airbyte_data', ['date_start'], ['date_start']) }} as date_start,
    {{ json_extract_scalar('_airbyte_data', ['unique_ctr'], ['unique_ctr']) }} as unique_ctr,
    {{ json_extract_scalar('_airbyte_data', ['auction_bid'], ['auction_bid']) }} as auction_bid,
    {{ json_extract_scalar('_airbyte_data', ['buying_type'], ['buying_type']) }} as buying_type,
    {{ json_extract_scalar('_airbyte_data', ['campaign_id'], ['campaign_id']) }} as campaign_id,
    {{ json_extract_array('_airbyte_data', ['conversions'], ['conversions']) }} as conversions,
    {{ json_extract_scalar('_airbyte_data', ['impressions'], ['impressions']) }} as impressions,
    {{ json_extract_array('_airbyte_data', ['website_ctr'], ['website_ctr']) }} as website_ctr,
    {{ json_extract_scalar('_airbyte_data', ['account_name'], ['account_name']) }} as account_name,
    {{ json_extract_scalar('_airbyte_data', ['created_time'], ['created_time']) }} as created_time,
    {{ json_extract_scalar('_airbyte_data', ['social_spend'], ['social_spend']) }} as social_spend,
    {{ json_extract_scalar('_airbyte_data', ['updated_time'], ['updated_time']) }} as updated_time,
    {{ json_extract_array('_airbyte_data', ['action_values'], ['action_values']) }} as action_values,
    {{ json_extract_scalar('_airbyte_data', ['age_targeting'], ['age_targeting']) }} as age_targeting,
    {{ json_extract_scalar('_airbyte_data', ['campaign_name'], ['campaign_name']) }} as campaign_name,
    {{ json_extract_array('_airbyte_data', ['purchase_roas'], ['purchase_roas']) }} as purchase_roas,
    {{ json_extract_scalar('_airbyte_data', ['unique_clicks'], ['unique_clicks']) }} as unique_clicks,
    {{ json_extract_array('_airbyte_data', ['unique_actions'], ['unique_actions']) }} as unique_actions,
    {{ json_extract_scalar('_airbyte_data', ['full_view_reach'], ['full_view_reach']) }} as full_view_reach,
    {{ json_extract_array('_airbyte_data', ['outbound_clicks'], ['outbound_clicks']) }} as outbound_clicks,
    {{ json_extract_scalar('_airbyte_data', ['quality_ranking'], ['quality_ranking']) }} as quality_ranking,
    {{ json_extract_scalar('_airbyte_data', ['account_currency'], ['account_currency']) }} as account_currency,
    {{ json_extract_array('_airbyte_data', ['ad_click_actions'], ['ad_click_actions']) }} as ad_click_actions,
    {{ json_extract_scalar('_airbyte_data', ['gender_targeting'], ['gender_targeting']) }} as gender_targeting,
    {{ json_extract_array('_airbyte_data', ['conversion_values'], ['conversion_values']) }} as conversion_values,
    {{ json_extract_array('_airbyte_data', ['cost_per_ad_click'], ['cost_per_ad_click']) }} as cost_per_ad_click,
    {{ json_extract_array('_airbyte_data', ['cost_per_thruplay'], ['cost_per_thruplay']) }} as cost_per_thruplay,
    {{ json_extract_scalar('_airbyte_data', ['impression_device'], ['impression_device']) }} as impression_device,
    {{ json_extract_scalar('_airbyte_data', ['optimization_goal'], ['optimization_goal']) }} as optimization_goal,
    {{ json_extract_scalar('_airbyte_data', ['platform_position'], ['platform_position']) }} as platform_position,
    {{ json_extract_scalar('_airbyte_data', ['inline_link_clicks'], ['inline_link_clicks']) }} as inline_link_clicks,
    {{ json_extract_scalar('_airbyte_data', ['publisher_platform'], ['publisher_platform']) }} as publisher_platform,
    {{ json_extract_array('_airbyte_data', ['video_play_actions'], ['video_play_actions']) }} as video_play_actions,
    {{ json_extract_scalar('_airbyte_data', ['attribution_setting'], ['attribution_setting']) }} as attribution_setting,
    {{ json_extract_array('_airbyte_data', ['cost_per_conversion'], ['cost_per_conversion']) }} as cost_per_conversion,
    {{ json_extract_array('_airbyte_data', ['outbound_clicks_ctr'], ['outbound_clicks_ctr']) }} as outbound_clicks_ctr,
    {{ json_extract_scalar('_airbyte_data', ['canvas_avg_view_time'], ['canvas_avg_view_time']) }} as canvas_avg_view_time,
    {{ json_extract_array('_airbyte_data', ['cost_per_action_type'], ['cost_per_action_type']) }} as cost_per_action_type,
    {{ json_extract_array('_airbyte_data', ['ad_impression_actions'], ['ad_impression_actions']) }} as ad_impression_actions,
    {{ json_extract_array('_airbyte_data', ['catalog_segment_value'], ['catalog_segment_value']) }} as catalog_segment_value,
    {{ json_extract_scalar('_airbyte_data', ['cost_per_unique_click'], ['cost_per_unique_click']) }} as cost_per_unique_click,
    {{ json_extract_scalar('_airbyte_data', ['full_view_impressions'], ['full_view_impressions']) }} as full_view_impressions,
    {{ json_extract_scalar('_airbyte_data', ['inline_link_click_ctr'], ['inline_link_click_ctr']) }} as inline_link_click_ctr,
    {{ json_extract_array('_airbyte_data', ['website_purchase_roas'], ['website_purchase_roas']) }} as website_purchase_roas,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recallers'], ['estimated_ad_recallers']) }} as estimated_ad_recallers,
    {{ json_extract_scalar('_airbyte_data', ['inline_post_engagement'], ['inline_post_engagement']) }} as inline_post_engagement,
    {{ json_extract_scalar('_airbyte_data', ['unique_link_clicks_ctr'], ['unique_link_clicks_ctr']) }} as unique_link_clicks_ctr,
    {{ json_extract_array('_airbyte_data', ['unique_outbound_clicks'], ['unique_outbound_clicks']) }} as unique_outbound_clicks,
    {{ json_extract_scalar('_airbyte_data', ['auction_competitiveness'], ['auction_competitiveness']) }} as auction_competitiveness,
    {{ json_extract_scalar('_airbyte_data', ['canvas_avg_view_percent'], ['canvas_avg_view_percent']) }} as canvas_avg_view_percent,
    {{ json_extract_array('_airbyte_data', ['catalog_segment_actions'], ['catalog_segment_actions']) }} as catalog_segment_actions,
    {{ json_extract_scalar('_airbyte_data', ['conversion_rate_ranking'], ['conversion_rate_ranking']) }} as conversion_rate_ranking,
    {{ json_extract_array('_airbyte_data', ['converted_product_value'], ['converted_product_value']) }} as converted_product_value,
    {{ json_extract_array('_airbyte_data', ['cost_per_outbound_click'], ['cost_per_outbound_click']) }} as cost_per_outbound_click,
    {{ json_extract_scalar('_airbyte_data', ['engagement_rate_ranking'], ['engagement_rate_ranking']) }} as engagement_rate_ranking,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recall_rate'], ['estimated_ad_recall_rate']) }} as estimated_ad_recall_rate,
    {{ json_extract_array('_airbyte_data', ['mobile_app_purchase_roas'], ['mobile_app_purchase_roas']) }} as mobile_app_purchase_roas,
    {{ json_extract_array('_airbyte_data', ['video_play_curve_actions'], ['video_play_curve_actions']) }} as video_play_curve_actions,
    {{ json_extract_scalar('_airbyte_data', ['unique_inline_link_clicks'], ['unique_inline_link_clicks']) }} as unique_inline_link_clicks,
    {{ json_extract_array('_airbyte_data', ['video_p25_watched_actions'], ['video_p25_watched_actions']) }} as video_p25_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_p50_watched_actions'], ['video_p50_watched_actions']) }} as video_p50_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_p75_watched_actions'], ['video_p75_watched_actions']) }} as video_p75_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_p95_watched_actions'], ['video_p95_watched_actions']) }} as video_p95_watched_actions,
    {{ json_extract_scalar('_airbyte_data', ['auction_max_competitor_bid'], ['auction_max_competitor_bid']) }} as auction_max_competitor_bid,
    {{ json_extract_array('_airbyte_data', ['converted_product_quantity'], ['converted_product_quantity']) }} as converted_product_quantity,
    {{ json_extract_array('_airbyte_data', ['cost_per_15_sec_video_view'], ['cost_per_15_sec_video_view']) }} as cost_per_15_sec_video_view,
    {{ json_extract_scalar('_airbyte_data', ['cost_per_inline_link_click'], ['cost_per_inline_link_click']) }} as cost_per_inline_link_click,
    {{ json_extract_array('_airbyte_data', ['unique_outbound_clicks_ctr'], ['unique_outbound_clicks_ctr']) }} as unique_outbound_clicks_ctr,
    {{ json_extract_array('_airbyte_data', ['video_p100_watched_actions'], ['video_p100_watched_actions']) }} as video_p100_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_time_watched_actions'], ['video_time_watched_actions']) }} as video_time_watched_actions,
    {{ json_extract_array('_airbyte_data', ['cost_per_unique_action_type'], ['cost_per_unique_action_type']) }} as cost_per_unique_action_type,
    {{ json_extract_scalar('_airbyte_data', ['unique_inline_link_click_ctr'], ['unique_inline_link_click_ctr']) }} as unique_inline_link_click_ctr,
    {{ json_extract_array('_airbyte_data', ['video_15_sec_watched_actions'], ['video_15_sec_watched_actions']) }} as video_15_sec_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_30_sec_watched_actions'], ['video_30_sec_watched_actions']) }} as video_30_sec_watched_actions,
    {{ json_extract_array('_airbyte_data', ['cost_per_unique_outbound_click'], ['cost_per_unique_outbound_click']) }} as cost_per_unique_outbound_click,
    {{ json_extract_array('_airbyte_data', ['video_avg_time_watched_actions'], ['video_avg_time_watched_actions']) }} as video_avg_time_watched_actions,
    {{ json_extract_scalar('_airbyte_data', ['cost_per_estimated_ad_recallers'], ['cost_per_estimated_ad_recallers']) }} as cost_per_estimated_ad_recallers,
    {{ json_extract_scalar('_airbyte_data', ['cost_per_inline_post_engagement'], ['cost_per_inline_post_engagement']) }} as cost_per_inline_post_engagement,
    {{ json_extract_scalar('_airbyte_data', ['cost_per_unique_inline_link_click'], ['cost_per_unique_inline_link_click']) }} as cost_per_unique_inline_link_click,
    {{ json_extract_scalar('_airbyte_data', ['instant_experience_clicks_to_open'], ['instant_experience_clicks_to_open']) }} as instant_experience_clicks_to_open,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recallers_lower_bound'], ['estimated_ad_recallers_lower_bound']) }} as estimated_ad_recallers_lower_bound,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recallers_upper_bound'], ['estimated_ad_recallers_upper_bound']) }} as estimated_ad_recallers_upper_bound,
    {{ json_extract_scalar('_airbyte_data', ['instant_experience_clicks_to_start'], ['instant_experience_clicks_to_start']) }} as instant_experience_clicks_to_start,
    {{ json_extract_array('_airbyte_data', ['instant_experience_outbound_clicks'], ['instant_experience_outbound_clicks']) }} as instant_experience_outbound_clicks,
    {{ json_extract_array('_airbyte_data', ['video_play_retention_graph_actions'], ['video_play_retention_graph_actions']) }} as video_play_retention_graph_actions,
    {{ json_extract_array('_airbyte_data', ['cost_per_2_sec_continuous_video_view'], ['cost_per_2_sec_continuous_video_view']) }} as cost_per_2_sec_continuous_video_view,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recall_rate_lower_bound'], ['estimated_ad_recall_rate_lower_bound']) }} as estimated_ad_recall_rate_lower_bound,
    {{ json_extract_scalar('_airbyte_data', ['estimated_ad_recall_rate_upper_bound'], ['estimated_ad_recall_rate_upper_bound']) }} as estimated_ad_recall_rate_upper_bound,
    {{ json_extract_array('_airbyte_data', ['video_play_retention_0_to_15s_actions'], ['video_play_retention_0_to_15s_actions']) }} as video_play_retention_0_to_15s_actions,
    {{ json_extract_array('_airbyte_data', ['video_continuous_2_sec_watched_actions'], ['video_continuous_2_sec_watched_actions']) }} as video_continuous_2_sec_watched_actions,
    {{ json_extract_array('_airbyte_data', ['video_play_retention_20_to_60s_actions'], ['video_play_retention_20_to_60s_actions']) }} as video_play_retention_20_to_60s_actions,
    {{ json_extract_scalar('_airbyte_data', ['qualifying_question_qualify_answer_rate'], ['qualifying_question_qualify_answer_rate']) }} as qualifying_question_qualify_answer_rate,
    {{ json_extract_array('_airbyte_data', ['catalog_segment_value_omni_purchase_roas'], ['catalog_segment_value_omni_purchase_roas']) }} as catalog_segment_value_omni_purchase_roas,
    {{ json_extract_array('_airbyte_data', ['catalog_segment_value_mobile_purchase_roas'], ['catalog_segment_value_mobile_purchase_roas']) }} as catalog_segment_value_mobile_purchase_roas,
    {{ json_extract_array('_airbyte_data', ['catalog_segment_value_website_purchase_roas'], ['catalog_segment_value_website_purchase_roas']) }} as catalog_segment_value_website_purchase_roas,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_ads_insights_platform_and_device') }}
-- ads_insights_platform_and_device
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

