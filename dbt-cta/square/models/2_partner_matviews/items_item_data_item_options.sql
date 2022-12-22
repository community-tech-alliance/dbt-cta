
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','items_item_data_item_options_base') }}
  