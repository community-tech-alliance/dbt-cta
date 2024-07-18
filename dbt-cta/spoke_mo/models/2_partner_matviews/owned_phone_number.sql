select
    service,
    allocated_to_id,
    area_code,
    service_id,
    allocated_to,
    organization_id,
    created_at,
    phone_number,
    id,
    allocated_at,
    _airbyte_extracted_at,
    _airbyte_owned_phone_number_hashid
from {{ source('cta','owned_phone_number_base') }}