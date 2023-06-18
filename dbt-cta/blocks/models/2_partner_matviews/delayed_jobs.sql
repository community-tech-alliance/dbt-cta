
SELECT
    *
FROM {{ source('cta', 'delayed_jobs_base') }}
