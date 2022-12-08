
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','items_item_data_base') }}
  