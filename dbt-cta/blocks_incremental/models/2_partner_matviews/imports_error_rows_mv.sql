
SELECT
    *
FROM  {{ source('cta', 'imports_error_rows_base') }}