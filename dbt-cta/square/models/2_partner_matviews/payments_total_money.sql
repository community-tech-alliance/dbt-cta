
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_total_money_base') }}
  