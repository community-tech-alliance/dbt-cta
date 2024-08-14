select
    date,
    applicant_id,
    job_id,
    rating,
    id,
    workflow_step_id,
    _airbyte_extracted_at,
    _airbyte_applicants_to_jobs_hashid
from {{ source('cta','applicants_to_jobs_base') }}