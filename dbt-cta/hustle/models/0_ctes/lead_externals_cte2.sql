-- ensures the base model contains only one row per _cta_hashid

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _cta_hashid ORDER BY updated_at desc) as rownum 
FROM {{ ref('lead_externals_cte1') }}
)
where rownum=1