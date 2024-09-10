
SELECT
    *
FROM  {{ source('cta', 'ticket_pipelines_base') }}