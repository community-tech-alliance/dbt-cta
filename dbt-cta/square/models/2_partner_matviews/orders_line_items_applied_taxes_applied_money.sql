
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_line_items_applied_taxes_applied_money_base') }}
  