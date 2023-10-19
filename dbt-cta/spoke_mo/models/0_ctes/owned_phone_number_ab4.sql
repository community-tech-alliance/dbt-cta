-- ensures the base model contains only one row per id

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY _airbyte_emitted_at desc) as rownum 
FROM {{ ref('owned_phone_number_ab3') }}
)
where rownum=1