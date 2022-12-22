
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_card_details_card_base') }}
  