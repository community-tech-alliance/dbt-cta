SELECT
    *
FROM {{ source('cta', 'account_report_base') }}
