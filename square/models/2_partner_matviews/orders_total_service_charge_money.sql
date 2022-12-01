
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_total_service_charge_money_base') }}
  