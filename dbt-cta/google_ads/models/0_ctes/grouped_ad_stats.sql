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
from {{ source('partner', 'p_AdStats_1731221521') }}
group by Date, CampaignId, AdGroupId, CreativeId, Device, AdNetworkType1, AdNetworkType2