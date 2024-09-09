
SELECT
    *
FROM  {{ source('cta', 'email_subscriptions_base') }}