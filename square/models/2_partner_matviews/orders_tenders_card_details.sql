
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_tenders_card_details_base') }}
  