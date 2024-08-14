select *
from {{ source('cta','payments_approved_money_base') }}
