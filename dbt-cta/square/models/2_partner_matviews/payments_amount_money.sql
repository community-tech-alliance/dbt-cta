
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_amount_money_base') }}
  