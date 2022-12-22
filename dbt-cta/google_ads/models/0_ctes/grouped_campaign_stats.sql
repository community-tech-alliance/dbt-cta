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

{% set CampaignBasicStats = var('CampaignBasicStats') %}
from {{ source('partner', CampaignBasicStats) }} as table_alias
group by Date, CampaignId, AdNetworkType1, AdNetworkType2