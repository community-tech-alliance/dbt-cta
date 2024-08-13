select * from {{ source('cta','checkout_sessions_line_items_price_transform_quantity_base') }}
