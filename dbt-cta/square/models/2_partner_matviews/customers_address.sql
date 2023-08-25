{{ config(full_refresh=false) }}
select *
from {{ source('cta','customers_address_base') }}
