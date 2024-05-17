SELECT
    *
FROM {{ source('cta', 'ads_insights_overall_base') }}
