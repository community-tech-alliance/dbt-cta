{{ config(full_refresh=false) }}
select *
from {{ source('cta','modifier_list_modifier_list_data_modifiers_modifier_data_base') }}
