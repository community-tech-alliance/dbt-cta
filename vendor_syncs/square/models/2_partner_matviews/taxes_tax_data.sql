
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','taxes_tax_data_base') }}
  