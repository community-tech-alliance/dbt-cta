{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_service_charges_total_tax_money_base') }}
