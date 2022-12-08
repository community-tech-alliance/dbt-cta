
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_source_base') }}
  