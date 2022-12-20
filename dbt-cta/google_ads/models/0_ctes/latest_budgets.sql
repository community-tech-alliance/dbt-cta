{% set Budget = var('Budget') %}

{%- call statement('latest_partition', fetch_result=True) -%}
    select max(_PARTITIONDATE) from {{ source('partner',Budget) }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select 
  BudgetId,
  TotalAmount
from {{ source('partner', Budget) }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'