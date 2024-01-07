-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_import_files_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('import_files_ab1') }}
)
where rownum=1