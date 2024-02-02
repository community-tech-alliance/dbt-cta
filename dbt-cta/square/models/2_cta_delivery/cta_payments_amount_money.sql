select *
from {{ source('cta','payments_amount_money_base') }}
