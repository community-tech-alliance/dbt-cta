select * from {{ source('cta','checkout_sessions_line_items_price_recurring_base') }}
