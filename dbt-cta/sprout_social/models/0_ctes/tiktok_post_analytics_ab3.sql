-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_tiktok_post_analytics_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('tiktok_post_analytics_ab2') }}
)
where rownum=1