
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','shifts_breaks_base') }}
  