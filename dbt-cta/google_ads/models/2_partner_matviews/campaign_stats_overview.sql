select
  Date,
  CampaignId,
  CampaignName,
  AdNetworkType1,
  AdNetworkType2,
  BudgetId,
  BudgetTotalAmount,
  Impressions,
  Cost,
  AverageCpm,
  Clicks,
  Ctr,
  ImpressionReach,
  AverageFrequency
from {{ source('cta', 'campaign_stats_overview_base') }}