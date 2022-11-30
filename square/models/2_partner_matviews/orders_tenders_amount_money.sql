
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_tenders_amount_money_base') }}
  