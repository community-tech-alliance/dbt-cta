
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','modifier_list_base') }}
  