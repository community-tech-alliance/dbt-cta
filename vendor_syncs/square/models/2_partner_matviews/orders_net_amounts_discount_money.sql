
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_net_amounts_discount_money_base') }}
  