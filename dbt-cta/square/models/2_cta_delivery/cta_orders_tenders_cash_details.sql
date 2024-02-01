select *
from {{ source('cta','orders_tenders_cash_details_base') }}
