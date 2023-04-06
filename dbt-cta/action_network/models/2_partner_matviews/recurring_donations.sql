select
    id,
    status,
    values,
    user_id,
    created_at,
    updated_at,
    next_payment,
    failure_count,
    fundraising_id,
    recurring_period
from {{ source('cta','recurring_donations_base') }}