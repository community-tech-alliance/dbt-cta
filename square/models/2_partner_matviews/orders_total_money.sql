
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_total_money_base') }}
  