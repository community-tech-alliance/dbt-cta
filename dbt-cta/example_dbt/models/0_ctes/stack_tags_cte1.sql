{{ config(materialized='ephemeral') }}

WITH
count_res AS (
SELECT
SPLIT(tags,'|') AS tech
FROM
`bigquery-public-data.stackoverflow.posts_questions`
WHERE
EXTRACT (YEAR
FROM
creation_date)>2020 ),
tags_unnested AS (
SELECT
splitted_tags,
COUNT(*) AS tech_count
FROM
count_res
CROSS JOIN
UNNEST(tech) splitted_tags
GROUP BY
splitted_tags
ORDER BY
tech_count DESC )
SELECT
*
FROM
tags_unnested