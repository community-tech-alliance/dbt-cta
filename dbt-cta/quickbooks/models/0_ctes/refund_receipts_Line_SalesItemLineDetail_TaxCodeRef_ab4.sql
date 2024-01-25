-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_refund_receipts_Line_SalesItemLineDetail_TaxCodeRef_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {{ ref('refund_receipts_Line_SalesItemLineDetail_TaxCodeRef_ab3') }}
)
where rownum=1