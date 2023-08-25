{{ config(full_refresh=false) }}
select *
from {{ source('cta','items_item_data_variations_item_variation_data_location_overrides_base') }}
