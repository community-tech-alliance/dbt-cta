
SELECT
    *
FROM {{ source('cta', 'voted_labels_base') }}
