
SELECT
    *
FROM  {{ source('cta', 'event_documents_base') }}