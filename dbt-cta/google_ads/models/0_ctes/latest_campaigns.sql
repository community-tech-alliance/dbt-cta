{% set partition_time = latest_partition(generate_database_name(), generate_schema_name(), 'p_Budget_1731221521') %}

select
  CampaignId,
  CampaignName,
  BudgetId,
  UrlCustomParameters
from {{ source('partner', 'p_Campaign_1731221521') }} as table_alias
--PROD
--where _PARTITIONTIME = '{{ partition_time }}'
--DEV
where date_partition = '{{ partition_time }}'