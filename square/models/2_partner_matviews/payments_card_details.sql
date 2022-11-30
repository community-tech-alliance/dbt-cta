
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_card_details_base') }}
  