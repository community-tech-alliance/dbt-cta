{{ config(full_refresh=false) }}
select *
from {{ source('cta','items_item_data_variations_item_variation_data_item_option_values_base') }}
