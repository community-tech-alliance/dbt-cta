
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_tenders_cash_details_buyer_tendered_money_base') }}
  