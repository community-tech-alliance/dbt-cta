
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_base') }}
  