
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_refunds_amount_money_base') }}
  