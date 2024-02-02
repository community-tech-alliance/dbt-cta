
SELECT
    *
FROM  {{ source('cta', 'query_results_base') }}