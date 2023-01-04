--depends on: {{ ref('ad_stats_overview_base') }}

select
  Date,
  CampaignId,
  CampaignName,
  AdGroupId,
  AdGroupName,
  CreativeId,
  ImageCreativeName,
  utm_source,
  utm_medium,
  utm_campaign,
  utm_term,
  utm_content,
  Device,
  AdNetworkType1,
  AdNetworkType2,
  BudgetId,
  BudgetTotalAmount,
  Impressions,
  Cost,
  AverageCpm,
  Clicks,
  Ctr,
  Engagements,
  VideoQuartile100Rate,
  VideoQuartile75Rate,
  VideoQuartile50Rate,
  VideoQuartile25Rate,
  VideoViews
from {{ ref('ad_stats_overview_base') }}