select *
from {{ source('cta','orders_service_charges_total_money_base') }}
