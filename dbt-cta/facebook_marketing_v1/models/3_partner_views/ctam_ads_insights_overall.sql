-- depends_on: {{ ref('ad_account') }}, {{ ref('account_report') }}, {{ ref('ad_creatives') }}, {{ ref('ad_set_report') }}, {{ ref('ad_sets') }}, {{ ref('ads_insights_overall') }}, {{ ref('ads_insights_platform_and_device') }}, {{ ref('ads') }}, {{ ref('campaign_report') }}, {{ ref('campaigns') }}


with stats as (
    select
        --------------------------------------
        -- EVERYTHING PROVIDED BY FB API
        --------------------------------------
        *,
        --------------------------------
        -- CUSTOM CONVERSION METRICS
        --------------------------------
        case when impressions > 0 then inline_link_clicks / impressions end as ctr_calculated,
        case when impressions > 0 then landing_page_views / impressions end as page_view_rate_calculated,
        case when impressions > 0 then video_p100_watched / impressions end as video_completion_rate_calculated

    from {{ source('partner', 'ads_insights_overall') }}
),

ads as (
    select
        a.id as ad_id,
        a.adset_id,
        a.creative_id,
        a.name as ad_name,
        c.title,
        c.body,
        c.utm_source,
        c.utm_medium,
        c.utm_campaign,
        c.utm_term,
        c.utm_content
    from {{ source('partner', 'ads') }} as a
    left join {{ source('partner', 'ad_creatives') }} as c
        on a.creative_id = c.id
),

ad_sets as (
    select
        id as adset_id,
        campaign_id,
        name as adset_name,
        daily_budget / 1000000 as adset_daily_budget,
        lifetime_budget / 1000000 as adset_lifetime_budget
    from {{ source('partner', 'ad_sets') }}
),


campaigns as (
    select
        id as campaign_id,
        name as campaign_name,
        objective as campaign_objective
    from {{ source('partner', 'campaigns') }}
),

join1 as (
    select
        campaigns.campaign_id,
        campaign_name,
        campaign_objective,
        adset_id,
        adset_name,
        adset_daily_budget,
        adset_lifetime_budget
    from campaigns
    left join ad_sets on campaigns.campaign_id = ad_sets.campaign_id
),

join2 as (
select
    join1.adset_id,
    campaign_id,
    campaign_name,
    campaign_objective,
    adset_name,
    adset_daily_budget,
    adset_lifetime_budget,
    ad_id,
    creative_id,
    ad_name,
    title,
    body,
    utm_source,
    utm_medium,
    utm_campaign,
    utm_term,
    utm_content
from join1
left join ads on join1.adset_id = ads.adset_id
)

select
stats.date_start,
stats.date_stop,
stats.ad_id,
join2.adset_id,
join2.campaign_id,
join2.campaign_name,
join2.campaign_objective,
join2.adset_name,
join2.adset_daily_budget,
join2.adset_lifetime_budget,
join2.creative_id,
join2.ad_name,
join2.title,
join2.body,
join2.utm_source,
join2.utm_medium,
join2.utm_campaign,
join2.utm_term,
join2.utm_content,
stats.cpc,
stats.cpm,
stats.cpp,
stats.ctr,
stats.website_ctr,
stats.ctr_calculated,
stats.page_view_rate_calculated,
stats.video_completion_rate_calculated,
stats.reach,
stats.spend,
stats.clicks,
stats.labels,
stats.location,
stats.wish_bid,
stats.frequency,
stats.objective,
stats.account_id,
stats.unique_ctr,
stats.auction_bid,
stats.buying_type,
stats.impressions,
stats.account_name,
stats.created_time,
stats.social_spend,
stats.updated_time,
stats.age_targeting,
stats.unique_clicks,
stats.full_view_reach,
stats.quality_ranking,
stats.account_currency,
stats.gender_targeting,
stats.optimization_goal,
stats.inline_link_clicks,
stats.attribution_setting,
stats.canvas_avg_view_time,
stats.cost_per_unique_click,
stats.full_view_impressions,
stats.inline_link_click_ctr,
stats.estimated_ad_recallers,
stats.inline_post_engagement,
stats.unique_link_clicks_ctr,
stats.auction_competitiveness,
stats.canvas_avg_view_percent,
stats.conversion_rate_ranking,
stats.engagement_rate_ranking,
stats.estimated_ad_recall_rate,
stats.unique_inline_link_clicks,
stats.auction_max_competitor_bid,
stats.cost_per_inline_link_click,
stats.unique_inline_link_click_ctr,
stats.cost_per_estimated_ad_recallers,
stats.cost_per_inline_post_engagement,
stats.cost_per_unique_inline_link_click,
stats.instant_experience_clicks_to_open,
stats.estimated_ad_recallers_lower_bound,
stats.estimated_ad_recallers_upper_bound,
stats.instant_experience_clicks_to_start,
stats.estimated_ad_recall_rate_lower_bound,
stats.estimated_ad_recall_rate_upper_bound,
stats.qualifying_question_qualify_answer_rate,
stats.video_played,
stats.video_continuous_2_sec_watched,
stats.cost_per_2_sec_continuous_video_view,
stats.video_15_sec_watched,
stats.cost_per_15_sec_video_view,
stats.video_15_sec_watched as thruplays,
stats.cost_per_thruplay,
stats.video_p25_watched,
stats.video_p50_watched,
stats.video_p75_watched,
stats.video_p95_watched,
stats.video_p100_watched,
stats.shares,
stats.landing_page_views,
stats.conversion_values,
stats._airbyte_emitted_at
from join2
left join stats on join2.ad_id = stats.ad_id
where
1 = 1
and spend > 0
