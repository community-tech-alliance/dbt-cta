
SELECT
    *
FROM  {{ source('cta', 'form_submissions_base') }}