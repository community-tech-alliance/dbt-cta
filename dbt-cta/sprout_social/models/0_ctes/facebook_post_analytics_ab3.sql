-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_facebook_post_analytics_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('facebook_post_analytics_ab2') }}
)
where rownum=1