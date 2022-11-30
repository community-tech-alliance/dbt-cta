
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_total_discount_money_base') }}
  