select
  campaigns.CampaignId,
  campaigns.CampaignName,
  campaigns.BudgetId,
  budgets.TotalAmount,
  campaigns.UrlCustomParameters
from {{ ref('latest_campaigns') }} campaigns
join {{ ref('latest_budgets') }} budgets on campaigns.BudgetId = budgets.BudgetId