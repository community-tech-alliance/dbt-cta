
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_fulfillments_shipment_details_base') }}
  