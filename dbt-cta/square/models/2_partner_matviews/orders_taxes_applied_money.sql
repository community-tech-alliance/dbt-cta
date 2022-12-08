
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_taxes_applied_money_base') }}
  