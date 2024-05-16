SELECT
    *
FROM {{ source('cta', 'ads_insights_platform_and_device_base') }}
