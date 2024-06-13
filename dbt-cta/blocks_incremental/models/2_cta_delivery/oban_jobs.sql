
SELECT
    *
FROM  {{ source('cta', 'oban_jobs_base') }}