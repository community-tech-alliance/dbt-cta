select
    id,
    created_at,
    updated_at,
    donation_id,
    recurring_donation_id,
    _airbyte_donations_recurring_donations_hashid
from {{ ref('donations_recurring_donations_base') }}