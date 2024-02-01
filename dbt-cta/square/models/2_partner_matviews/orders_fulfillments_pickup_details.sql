select *
from {{ source('cta','orders_fulfillments_pickup_details_base') }}
