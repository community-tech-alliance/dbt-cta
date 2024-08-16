select *
from {{ source('cta','payments_refunded_money_base') }}
