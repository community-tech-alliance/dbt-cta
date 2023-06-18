
SELECT
    *
FROM {{ source('cta', 'check_ins_base') }}
;
