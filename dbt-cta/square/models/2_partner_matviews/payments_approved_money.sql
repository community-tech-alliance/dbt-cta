
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_approved_money_base') }}
  