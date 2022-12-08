
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_refunded_money_base') }}
  