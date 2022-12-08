
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','modifier_list_modifier_list_data_modifiers_modifier_data_price_money_base') }}
  