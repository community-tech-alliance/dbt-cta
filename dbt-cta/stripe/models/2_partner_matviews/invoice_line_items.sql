select * from {{ source('cta','invoice_line_items_base') }}
