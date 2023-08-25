{{ config(full_refresh=false) }}
select *
from {{ source('cta','locations_address_base') }}
