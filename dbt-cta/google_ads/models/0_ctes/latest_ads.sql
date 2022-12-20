{% set Ad = var('Ad') %}

{%- call statement('latest_partition', fetch_result=True) -%}
    select max(_PARTITIONDATE) from {{ source('partner',Ad) }};
{%- endcall -%}

{%- set partition_time = load_result('latest_partition')['data'][0][0] -%}

select
  CreativeId,
  ImageCreativeName,
  CreativeUrlCustomParameters
from {{ source('partner', Ad) }} as table_alias
where _PARTITIONTIME = '{{ partition_time }}'