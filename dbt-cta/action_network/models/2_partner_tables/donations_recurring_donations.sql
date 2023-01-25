select
    id,
    created_at,
    updated_at,
    donation_id,
    recurring_donation_id
from {{ source('cta','donations_recurring_donations_base') }}