
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_line_items_total_discount_money_base') }}
  