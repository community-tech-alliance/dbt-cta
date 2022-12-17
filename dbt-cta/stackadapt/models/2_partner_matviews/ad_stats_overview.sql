select
  ad_stats.date,
  ad_stats.campaign_id,
  ad_stats.campaign,
  ad_stats.line_item_id,
  ad_stats.line_item,
  ad_stats.native_ad_id,
  ad_stats.nativead,
  ad_stats.click_url,
  ad_stats.utm_source,
  ad_stats.utm_medium,
  ad_stats.utm_campaign,
  ad_stats.utm_term,
  ad_stats.utm_content,
  safe_cast(campaigns.budget as string) as campaign_budget,
  safe_cast(line_items.budget as string) as line_item_budget,
  ad_stats.imp as impressions,
  ad_stats.cost,
  ad_stats.ecpm,
  ad_stats.ecpc,
  ad_stats.vcomp_0,
  ad_stats.vcomp_25,
  ad_stats.vcomp_50,
  ad_stats.vcomp_75,
  ad_stats.vcomp_95,
  ad_stats.vcomp_rate,
  ad_stats.click,
  ad_stats.ctr,
  ad_stats.page_start,
  ad_stats.page_time_15s,
  ad_stats.view_percent,
  safe_divide(ad_stats.page_start, ad_stats.imp) as pageview_rate,
  ad_stats.reach,
  ad_stats.frequency
from {{ source('cta', 'account_native_ads_stats') }} ad_stats
join {{ source('cta', 'campaigns') }} campaigns on ad_stats.campaign_id = campaigns.id
join {{ source('cta', 'line_items') }} line_items on ad_stats.line_item_id = line_items.id