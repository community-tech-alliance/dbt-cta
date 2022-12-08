
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_total_tax_money_base') }}
  