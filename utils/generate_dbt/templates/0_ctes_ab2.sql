-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

SELECT * EXCEPT (rownum) FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_{{ table }}_hashid ORDER BY _airbyte_extracted_at desc) as rownum 
from {% raw %}{{ ref('{% endraw %}{{ table }}{% raw %}_ab1') }}{% endraw %}
)
where rownum=1