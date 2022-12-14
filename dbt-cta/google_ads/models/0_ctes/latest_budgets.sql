{%- call statement('latest_partition', fetch_result=True) -%}
    --PROD:
    --select max(_PARTITIONDATE) from {{ source('partner','p_Budget_1731221521') }};

    --DEV (I couldn't get the _PARTITIONDATE pseudocolumn to work...)
    select max(date_partition) from {{ source('partner','p_Budget_1731221521') }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select 
  BudgetId,
  TotalAmount
from {{ source('partner', 'p_Budget_1731221521') }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'