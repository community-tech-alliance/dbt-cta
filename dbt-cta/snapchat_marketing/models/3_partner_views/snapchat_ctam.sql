-- depends_on: {{ ref('adaccounts') }}, {{ ref('ad_stats') }}, {{ ref('ads') }}, {{ ref('adsquads_skadnetwork_properties') }}, {{ ref('adsquads_targeting_geos') }}, {{ ref('adsquads_targeting') }}, {{ ref('adsquads') }}, {{ ref('campaigns') }}, {{ ref('creatives_web_view_properties') }}, {{ ref('creatives') }}, {{ ref('media') }}, {{ ref('organizations_configuration_settings') }}, {{ ref('organizations') }}, {{ ref('segments') }}

with stats as (
    select
        id as ad_id,
        swipe_ups as clicks,
        total_impressions as impressions,
        spend,
        video_views,
        quartile_1,
        quartile_2,
        quartile_3,
        view_completion,
        conversion_page_views,
        total_reach as reach,
        frequency,
        date(start_time) as start_date,
        case when total_impressions > 0 then spend / (total_impressions * 1000) else 0 end as cpm,
        case when total_impressions > 0 then swipe_ups / total_impressions else 0 end as ctr,
        case when total_impressions > 0 then conversion_page_views / total_impressions else 0 end as pvr, --previously called "uniques"
        case when video_views > 0 then view_completion / video_views else 0 end as vcr
    from {{ source('cta_delivery', 'ad_stats') }}
),

ads as (
    select
        a.id as ad_id,
        a.ad_squad_id,
        a.creative_id,
        a.name as ad_name,
        a.type as ad_type,
        c.utm_source,
        c.utm_medium,
        c.utm_campaign,
        c.utm_term,
        c.utm_content
    from {{ source('cta_delivery', 'ads') }} as a
    left join {{ source('cta_delivery', 'creatives') }} as c
        on a.creative_id = c.id
),

ad_sets as (
    select
        id as ad_squad_id,
        campaign_id,
        name as adset_name,
        daily_budget_micro as adsquad_daily_budget,
        lifetime_budget_micro as adsquad_lifetime_budget
    from {{ source('cta_delivery', 'adsquads') }}
),


campaigns as (
    select
        id as campaign_id,
        name as campaign_name,
        objective as campaign_objective
    from {{ source('cta_delivery', 'campaigns') }}
),

join1 as (
    select *
    from campaigns
    left join ad_sets on campaigns.campaign_id = ad_sets.campaign_id
),

join2 as (
select *
from join1
left join ads on join1.ad_squad_id = ads.ad_squad_id
),

final_cte as (
select *
from join2
left join stats on join2.ad_id = stats.ad_id
)

select
start_date,
campaign_objective,
campaign_name,
adset_name,
ad_name,
ad_type,
utm_source,
utm_medium,
utm_campaign,
utm_term,
utm_content,
spend,
clicks,
impressions,
video_views,
quartile_1,
quartile_2,
quartile_3,
view_completion,
conversion_page_views,
cpm,
ctr,
pvr,
vcr,
reach,
frequency,
adsquad_daily_budget / 1000000 as adsquad_daily_budget,
adsquad_lifetime_budget / 1000000 as adsquad_lifetime_budget
from final_cte
where spend > 0
