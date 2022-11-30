
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','refunds_processing_fee_base') }}
  