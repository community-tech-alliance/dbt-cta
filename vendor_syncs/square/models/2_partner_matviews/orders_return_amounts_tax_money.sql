
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_return_amounts_tax_money_base') }}
  