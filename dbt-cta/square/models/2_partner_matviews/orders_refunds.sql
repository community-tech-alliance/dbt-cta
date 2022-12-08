
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_refunds_base') }}
  