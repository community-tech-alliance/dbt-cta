select
    id,
    user_id,
    created_at,
    network_id,
    updated_at,
    accepted_terms,
    _airbyte_networks_users_hashid
from {{ source('cta','networks_users_base') }}
