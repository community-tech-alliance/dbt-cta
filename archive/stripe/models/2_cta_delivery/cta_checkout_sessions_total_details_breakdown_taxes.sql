select * from {{ source('cta','checkout_sessions_total_details_breakdown_taxes_base') }}
