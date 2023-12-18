-- ensures the base model contains only one row per id

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at desc) as rownum 
FROM {{ ref('voter_registration_scan_batch_cover_sheets_ab3') }}
)
where rownum=1