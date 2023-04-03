-- SQL model to get latest `date_updated` values for each sid
-- depends_on: {{ ref('conferences_ab2') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY sid ORDER BY date_updated desc) as rownum 
FROM {{ ref('conferences_ab2') }}
)
where rownum=1