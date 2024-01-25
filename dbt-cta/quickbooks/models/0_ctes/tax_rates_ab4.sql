-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_tax_rates_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('tax_rates_ab3') }}
)
where rownum=1