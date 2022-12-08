-- depends_on: {{ source('partner', 'stack_tags') }}

SELECT
*
FROM
{{ source('partner', 'stack_tags') }}

