select
    id,
    uuid,
    bioid,
    status,
    call_id,
    created_at,
    updated_at,
    target_name,
    target_type,
    target_party,
    target_phone,
    target_state,
    call_duration,
    target_country,
    target_district,
    target_position
from {{ source('cta','call_targets_base') }}