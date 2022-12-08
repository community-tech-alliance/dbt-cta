
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_fulfillments_base') }}
  