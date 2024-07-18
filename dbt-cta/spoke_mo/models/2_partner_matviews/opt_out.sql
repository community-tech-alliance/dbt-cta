select
    reason_code,
    assignment_id,
    organization_id,
    created_at,
    id,
    cell,
    _airbyte_extracted_at,
    _airbyte_opt_out_hashid
from {{ source('cta','opt_out_base') }}