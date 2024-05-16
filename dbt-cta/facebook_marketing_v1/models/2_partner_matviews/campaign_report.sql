SELECT
    *
FROM {{ source('cta', 'campaign_report_base') }}
