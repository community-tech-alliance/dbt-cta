
SELECT
    *
FROM {{ source('cta', 'voter_histories_base') }}
;
