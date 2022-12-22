
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','categories_base') }}
  