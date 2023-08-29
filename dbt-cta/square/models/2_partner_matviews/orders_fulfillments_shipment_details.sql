{{ config(full_refresh=false) }}
select *
from {{ source('cta','orders_fulfillments_shipment_details_base') }}
