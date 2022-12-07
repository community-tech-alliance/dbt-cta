-- depends_on: {{ ref('stack_tags_cte1') }}
SELECT *
FROM {{ ref('stack_tags_cte1') }}