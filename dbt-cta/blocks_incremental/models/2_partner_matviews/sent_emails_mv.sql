
SELECT
    *
FROM  {{ source('cta', 'sent_emails_base') }}