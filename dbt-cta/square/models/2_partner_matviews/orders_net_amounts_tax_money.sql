
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_net_amounts_tax_money_base') }}
  