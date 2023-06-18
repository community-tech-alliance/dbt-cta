
SELECT
    *
FROM {{ source('cta', 'filter_rules_base') }}
;
