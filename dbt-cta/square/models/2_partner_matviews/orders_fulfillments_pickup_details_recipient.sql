
  {{ config(full_refresh=false) }}
  SELECT *
  FROM {{ source('cta','orders_fulfillments_pickup_details_recipient_base') }}
  