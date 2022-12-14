{{
  config(
    unique_key='hash_id'
  )
}}

-- depends_on: {{ ref('grouped_ad_stats') }}, {{ ref('campaigns_with_budget') }}, {{ ref('latest_ad_groups') }}, {{ ref('latest_ads') }}

select 
  ad_stats.Date,
  ad_stats.CampaignId,
  campaigns_budget.CampaignName,
  ad_stats.AdGroupId,
  ad_groups.AdGroupName,
  ad_stats.CreativeId,
  ads.ImageCreativeName,
  REGEXP_EXTRACT(Ad_final_url_suffix, r'utm_source=([^&]+)') as utm_source,
  REGEXP_EXTRACT(Ad_final_url_suffix, r'utm_medium=([^&]+)') as utm_medium,
  REGEXP_EXTRACT(Ad_final_url_suffix, r'utm_campaign=([^&]+)') as utm_campaign,
  REGEXP_EXTRACT(Ad_final_url_suffix, r'utm_term=([^&]+)') as utm_term,
  REGEXP_EXTRACT(Ad_final_url_suffix, r'utm_content=([^&]+)') as utm_content,
  ad_stats.Device,
  ad_stats.AdNetworkType1,
  ad_stats.AdNetworkType2,
  campaigns_budget.BudgetId,
  {{ string_millis_to_dollars('campaigns_budget.TotalAmount') }} as BudgetTotalAmount,
  ad_stats.Impressions,
  {{ millis_to_dollars('ad_stats.Cost') }} as Cost,
  {{ ad_stats_cpm('ad_stats.Cost', 'ad_stats.Impressions') }} as AverageCpm,
  ad_stats.Clicks,
  {{ ad_stats_ctr('ad_stats.Clicks', 'ad_stats.Impressions') }} as Ctr,
  video_nc_stats.Engagements,
  video_nc_stats.VideoQuartile100Rate,
  video_nc_stats.VideoQuartile75Rate,
  video_nc_stats.VideoQuartile50Rate,
  video_nc_stats.VideoQuartile25Rate,
  video_nc_stats.VideoViews,
  {{ dbt_utils.surrogate_key([
    'ad_stats.Date',
    'ad_stats.CampaignId',
    'ad_stats.AdGroupId',
    'ad_stats.CreativeId',
    'ad_stats.Device',
    'ad_stats.AdNetworkType1',
    'ad_stats.AdNetworkType2'
  ]) }} as hash_id
from {{ ref('grouped_ad_stats') }} ad_stats
join {{ ref('campaigns_with_budget') }} campaigns_budget on ad_stats.CampaignId = campaigns_budget.CampaignId
join {{ ref('latest_ad_groups') }} ad_groups on ad_stats.AdGroupId = ad_groups.AdGroupId
join {{ ref('latest_ads') }} ads on ad_stats.CreativeId = ads.CreativeId
join {{ source('partner', 'ads_final_url_suffix') }} ad_final_url
  on ad_stats.CreativeId = ad_final_url.Ad_ID
join {{ source('partner', 'p_VideoNonClickStats_1731221521') }} video_nc_stats 
  on ad_stats.Date = video_nc_stats.Date
  and ad_stats.CampaignId = video_nc_stats.CampaignId
  and ad_stats.AdGroupId = video_nc_stats.AdGroupId
  and ad_stats.CreativeId = video_nc_stats.CreativeId
  and ad_stats.Device = video_nc_stats.Device
  and ad_stats.AdNetworkType1 = video_nc_stats.AdNetworkType1
  and ad_stats.AdNetworkType2 = video_nc_stats.AdNetworkType2
