
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','discounts_discount_data_amount_money_base') }}
  