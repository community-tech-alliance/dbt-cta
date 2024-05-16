
-- depends_on: {{ source('cta', 'ad_set_report_base') }}
SELECT
    *
FROM {{ source('cta', 'ad_set_report_base') }}
