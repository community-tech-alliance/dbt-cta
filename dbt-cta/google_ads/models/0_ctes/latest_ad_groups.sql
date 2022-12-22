{% set AdGroup = var('AdGroup') %}

{%- call statement('latest_partition', fetch_result=True) -%}
    select max(_PARTITIONDATE) from {{ source('partner',AdGroup) }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select 
  AdGroupId,
  AdGroupName


from {{ source('partner', AdGroup) }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'