
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_returns_return_line_items_base') }}
  