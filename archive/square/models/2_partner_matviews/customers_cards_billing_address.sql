select *
from {{ source('cta','customers_cards_billing_address_base') }}
