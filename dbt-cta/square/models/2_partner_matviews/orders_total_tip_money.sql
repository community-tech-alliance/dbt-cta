
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_total_tip_money_base') }}
  