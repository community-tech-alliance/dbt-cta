
SELECT
    *
FROM  {{ source('cta', 'user_acquisition_first_user_source_medium_report_base') }}