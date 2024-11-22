select
    hired_time,
    applicant_id,
    job_id,
    id,
    workflow_step_id,
    workflow_step_name,
    hired_date,
    _airbyte_extracted_at,
    _airbyte_hires_hashid
from {{ source('cta','hires_base') }}
