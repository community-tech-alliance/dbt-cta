
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','payments_risk_evaluation_base') }}
  