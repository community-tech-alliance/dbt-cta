
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','customers_cards_billing_address_base') }}
  