select
    _airbyte_emitted_at,
    id,
    user_id,
    created_at,
    network_id,
    updated_at,
    accepted_terms
from {{ source('cta','networks_users_base') }}