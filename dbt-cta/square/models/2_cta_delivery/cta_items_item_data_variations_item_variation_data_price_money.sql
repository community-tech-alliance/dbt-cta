select *
from {{ source('cta','items_item_data_variations_item_variation_data_price_money_base') }}
