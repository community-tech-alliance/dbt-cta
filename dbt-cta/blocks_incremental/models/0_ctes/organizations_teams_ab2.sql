-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_organizations_teams_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('organizations_teams_ab1') }}
)
where rownum=1