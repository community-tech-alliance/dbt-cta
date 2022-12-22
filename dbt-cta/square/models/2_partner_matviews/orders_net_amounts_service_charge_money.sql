
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_net_amounts_service_charge_money_base') }}
  