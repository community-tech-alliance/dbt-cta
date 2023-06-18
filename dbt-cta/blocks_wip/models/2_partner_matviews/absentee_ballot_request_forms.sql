
SELECT
    *
FROM {{ source('cta', 'absentee_ballot_request_forms_base') }}
;
