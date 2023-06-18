
SELECT
    *
FROM {{ source('cta', 'import_files_base') }}
;
