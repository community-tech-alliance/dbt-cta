{% set Campaign = var('Campaign') %}

{%- call statement('latest_partition', fetch_result=True) -%}
    select max(_PARTITIONDATE) from {{ source('partner',Campaign) }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select
  CampaignId,
  CampaignName,
  BudgetId,
  UrlCustomParameters
from {{ source('partner', Campaign) }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'