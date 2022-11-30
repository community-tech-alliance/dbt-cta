
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','items_item_data_modifier_list_info_base') }}
  