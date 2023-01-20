select
    id,
    icon,
    name_type,
    created_at,
    updated_at,
    interact_id,
    name_plural,
    email_enabled,
    name_singular,
    address_enabled,
    language_enabled,
    phone_number_enabled,
    date_of_birth_enabled
from {{ source('cta','entity_types_base') }}
