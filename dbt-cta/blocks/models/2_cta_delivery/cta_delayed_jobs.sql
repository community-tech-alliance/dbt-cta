select *
from {{ source('cta', 'delayed_jobs_base') }}
