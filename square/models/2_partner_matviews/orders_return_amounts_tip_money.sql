
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_return_amounts_tip_money_base') }}
  