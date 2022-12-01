
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','customers_cards_base') }}
  