
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','shifts_wage_base') }}
  