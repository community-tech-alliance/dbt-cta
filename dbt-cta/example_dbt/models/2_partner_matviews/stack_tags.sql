-- depends_on: {{ source('cta', 'stack_tags_base') }}

SELECT
*
FROM
{{ source('cta', 'stack_tags_base') }}

