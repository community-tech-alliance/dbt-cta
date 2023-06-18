
SELECT
    *
FROM {{ source('cta', 'list_folders_base') }}
;
