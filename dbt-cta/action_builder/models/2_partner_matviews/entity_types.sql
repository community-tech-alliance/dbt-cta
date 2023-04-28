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
    social_enabled,
    address_enabled,
    language_enabled,
    phone_number_enabled,
    date_of_birth_enabled,
    _airbyte_entity_types_hashid
from {{ source('cta','entity_types_base') }}