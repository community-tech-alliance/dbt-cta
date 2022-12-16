{%- call statement('latest_partition', fetch_result=True) -%}
    select max(_PARTITIONDATE) from {{ source('partner','p_AdGroup_1731221521') }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select 
  AdGroupId,
  AdGroupName
from {{ source('partner', 'p_AdGroup_1731221521') }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'