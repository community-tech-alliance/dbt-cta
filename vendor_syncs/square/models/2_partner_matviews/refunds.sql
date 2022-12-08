
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','refunds_base') }}
  