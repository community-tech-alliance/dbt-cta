select *
from {{ source('cta','payments_card_details_card_payment_timeline_base') }}
