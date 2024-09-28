{{
  config(
    unique_key="_daily_campaign_dials_hashid",
    on_schema_change="append_new_columns"
  )
}}

select *
from {{ ref('daily_campaign_dials_cte2') }}
