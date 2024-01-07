
SELECT
    *
FROM  {{ source('cta', 'voter_registration_reports_form_lookback_by_turf_base') }}