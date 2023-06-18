
SELECT
    *
FROM {{ source('cta', 'captricity_batches_base') }}
;
