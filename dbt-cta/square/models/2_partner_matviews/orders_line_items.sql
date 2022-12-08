
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_line_items_base') }}
  