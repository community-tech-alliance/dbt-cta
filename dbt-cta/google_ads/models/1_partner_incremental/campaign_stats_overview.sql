{% set CampaignCookieStats = var('CampaignCookieStats') %}

{{
  config(
    unique_key='hash_id'
  )
}}

--depends_on: {{ ref('grouped_campaign_stats') }}, {{ ref('campaigns_with_budget') }}

select
  campaign_stats.Date,
  campaign_stats.CampaignId,
  campaigns_budget.CampaignName,
  campaign_stats.AdNetworkType1,
  campaign_stats.AdNetworkType2,
  campaigns_budget.BudgetId,
  {{ string_millis_to_dollars('campaigns_budget.TotalAmount') }} as BudgetTotalAmount,
  campaign_stats.Impressions,
  {{ millis_to_dollars('campaign_stats.Cost') }} as Cost,
  {{ ad_stats_cpm('campaign_stats.Cost', 'campaign_stats.Impressions') }} as AverageCpm,
  campaign_stats.Clicks,
  {{ ad_stats_ctr('campaign_stats.Clicks', 'campaign_stats.Impressions') }} as Ctr,
  cookie_stats.ImpressionReach,
  cookie_stats.AverageFrequency,
  {{ dbt_utils.surrogate_key([
    'campaign_stats.Date',
    'campaign_stats.CampaignId',
    'campaign_stats.AdNetworkType1',
    'campaign_stats.AdNetworkType2'
  ]) }} as hash_id
from {{ ref('grouped_campaign_stats') }} campaign_stats
join {{ ref('campaigns_with_budget') }} campaigns_budget on campaign_stats.CampaignId = campaigns_budget.CampaignId
left join {{ source('partner', CampaignCookieStats) }} cookie_stats
  on campaign_stats.Date = cookie_stats.Date
  and campaign_stats.CampaignId = cookie_stats.CampaignId
  and campaign_stats.AdNetworkType1 = cookie_stats.AdNetworkType1
  and campaign_stats.AdNetworkType2 = cookie_stats.AdNetworkType2
