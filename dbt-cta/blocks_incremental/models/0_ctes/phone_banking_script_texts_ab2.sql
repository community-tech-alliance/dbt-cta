-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_phone_banking_script_texts_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('phone_banking_script_texts_ab1') }}
)
where rownum=1