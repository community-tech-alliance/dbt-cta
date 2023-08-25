{{ config(full_refresh=false) }}
select *
from {{ source('cta','items_item_data_modifier_list_info_base') }}
