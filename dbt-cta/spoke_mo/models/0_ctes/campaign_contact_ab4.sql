-- ensures the base model contains only one row per id

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY _airbyte_extracted_at desc) as rownum 
FROM {{ ref('campaign_contact_ab3') }}
)
where rownum=1