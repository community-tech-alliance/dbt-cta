select *
from {{ source('cta','orders_fulfillments_shipment_details_recipient_address_base') }}
