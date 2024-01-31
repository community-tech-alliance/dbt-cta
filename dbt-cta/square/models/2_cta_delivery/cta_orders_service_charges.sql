{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_service_charges_base') }}
