{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_fulfillments_pickup_details_recipient_base') }}
