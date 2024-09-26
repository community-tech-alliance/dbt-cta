{{
  config(
    unique_key="_caller_activity_details_hashid",
    on_schema_change="append_new_columns"
  )
}}

select *
from {{ ref('caller_activity_details_cte2') }}
