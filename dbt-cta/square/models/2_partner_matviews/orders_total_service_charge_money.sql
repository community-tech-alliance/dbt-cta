select *
from {{ source('cta','orders_total_service_charge_money_base') }}
