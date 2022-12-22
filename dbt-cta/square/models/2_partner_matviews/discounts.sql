
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','discounts_base') }}
  