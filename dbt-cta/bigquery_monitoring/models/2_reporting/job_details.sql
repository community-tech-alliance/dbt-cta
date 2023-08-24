select jobs.*
from {{ ref('json_extract_job_details') }} as jobs
inner join {{ ref('distinct_job_names') }} using (jobName)
where
    jobs.resource_type = 'bigquery_project'
    and array_length(jobs.referencedTables) > 0
