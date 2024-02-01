{{ config(full_refresh=false) }}
select *
from {{ source('cta','customers_preferences_base') }}
