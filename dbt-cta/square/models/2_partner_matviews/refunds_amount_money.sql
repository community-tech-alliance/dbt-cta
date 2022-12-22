
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','refunds_amount_money_base') }}
  