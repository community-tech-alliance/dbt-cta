
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_service_charges_base') }}
  