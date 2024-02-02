select
    apply_date,
    job_id,
    last_name,
    id,
    job_title,
    first_name,
    prospect_phone,
    _airbyte_emitted_at,
    _airbyte_applicants_hashid
from {{ source('cta','applicants_base') }}