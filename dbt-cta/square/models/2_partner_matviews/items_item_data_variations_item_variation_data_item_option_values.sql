
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','items_item_data_variations_item_variation_data_item_option_values_base') }}
  