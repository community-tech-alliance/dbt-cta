select * from {{ source('cta','checkout_sessions_after_expiration_base') }}
