
SELECT
    *
FROM  {{ source('cta', 'subscription_statuses_base') }}