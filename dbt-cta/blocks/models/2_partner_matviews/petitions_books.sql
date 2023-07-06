
SELECT
    *
FROM {{ source('cta', 'petitions_books_base') }}
