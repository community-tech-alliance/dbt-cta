SELECT jobs.*
FROM {{ ref('json_extract_job_details') }} as jobs
JOIN {{ ref('distinct_job_names') }} as distinct_jobs using(jobName)
where
  jobs.resource_type = 'bigquery_project'
  and array_length(jobs.referencedTables)>0