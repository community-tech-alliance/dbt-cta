select *
from {{ source('cta','payments_total_money_base') }}
