
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_service_charges_amount_money_base') }}
  