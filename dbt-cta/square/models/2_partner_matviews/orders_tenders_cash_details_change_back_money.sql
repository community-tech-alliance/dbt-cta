
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_tenders_cash_details_change_back_money_base') }}
  