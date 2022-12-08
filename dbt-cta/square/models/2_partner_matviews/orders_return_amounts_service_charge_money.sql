
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_return_amounts_service_charge_money_base') }}
  