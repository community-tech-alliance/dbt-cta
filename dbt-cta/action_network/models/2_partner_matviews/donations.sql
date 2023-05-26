select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    amount,
    address,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    recurring,
    created_at,
    first_name,
    updated_at,
    display_name,
    total_amount,
    custom_amount,
    custom_fields,
    salesforce_id,
    fundraising_id,
    recurring_period,
    message_to_target,
    originating_system,
    updates_from_creator,
    updates_from_sponsor,
    _airbyte_donations_hashid
from {{ source('cta','donations_base') }}