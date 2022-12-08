
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','locations_address_base') }}
  