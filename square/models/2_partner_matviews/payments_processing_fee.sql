
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_processing_fee_base') }}
  