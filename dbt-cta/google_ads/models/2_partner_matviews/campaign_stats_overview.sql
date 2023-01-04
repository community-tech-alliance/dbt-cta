--depends on: {{ ref('campaign_stats_overview_base') }}

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
from {{ ref('campaign_stats_overview_base') }}