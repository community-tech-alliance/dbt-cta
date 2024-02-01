select *
from {{ source('cta','payments_card_details_base') }}
