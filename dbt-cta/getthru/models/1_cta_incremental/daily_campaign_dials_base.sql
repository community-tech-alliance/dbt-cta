{{
  config(
    unique_key="_daily_campaign_dials_hashid"
  )
}}

select *
from {{ ref('daily_campaign_dials_cte2') }}
