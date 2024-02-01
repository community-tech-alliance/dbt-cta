select *
from {{ source('cta','orders_return_amounts_service_charge_money_base') }}
