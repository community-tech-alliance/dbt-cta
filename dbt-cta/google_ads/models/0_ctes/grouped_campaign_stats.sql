select 
  Date,
  CampaignId,
  AdNetworkType1,
  AdNetworkType2,
  SUM(Cost) as Cost,
  SUM(Clicks) as Clicks,
  Sum(Conversions) as Conversions,
  Sum(Impressions) as Impressions,
  Sum(Interactions) as Interactions
from {{ source('partner', 'p_CampaignBasicStats_1731221521') }}
group by Date, CampaignId, AdNetworkType1, AdNetworkType2