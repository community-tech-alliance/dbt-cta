select * from {{ source('cta','checkout_sessions_line_items_taxes_base') }}
