select *
from {{ source('cta','orders_tenders_amount_money_base') }}
