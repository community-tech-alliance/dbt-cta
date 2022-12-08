
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','customers_base') }}
  