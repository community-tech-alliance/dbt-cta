select
  Date,
  CampaignId,
  AdGroupId,
  CreativeId,
  Device,
  AdNetworkType1,
  AdNetworkType2,
  sum(case when ClickType = "VIDEO_WEBSITE_CLICKS" then Impressions else 0 end) as Impressions,
  sum(Cost) as Cost,
  sum(Clicks) as Clicks

{% set AdStats = var('AdStats') %}
from {{ source('partner', AdStats) }} as table_alias  
group by Date, CampaignId, AdGroupId, CreativeId, Device, AdNetworkType1, AdNetworkType2