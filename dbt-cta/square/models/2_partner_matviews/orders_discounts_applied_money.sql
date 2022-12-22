
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_discounts_applied_money_base') }}
  