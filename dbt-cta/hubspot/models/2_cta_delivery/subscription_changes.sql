
SELECT
    *
FROM  {{ source('cta', 'subscription_changes_base') }}