{{
  config(
    unique_key="_caller_activity_details_hashid"
  )
}}

select *
from {{ ref('caller_activity_details_cte2') }}
