select *
from {{ source('cta','orders_tenders_card_details_base') }}
