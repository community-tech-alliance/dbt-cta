select
    zip,
    maximum_salary,
    questionnaire,
    send_to_job_boards,
    notes,
    original_open_date,
    city,
    board_code,
    description,
    minimum_salary,
    team_id,
    type,
    title,
    hiring_lead,
    internal_code,
    id,
    state,
    department,
    country_id,
    status,
    _airbyte_extracted_at,
    _airbyte_jobs_hashid
from {{ source('cta','jobs_base') }}
