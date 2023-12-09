{% raw %}
SELECT
    *
FROM  {{ source('cta', {% endraw %}'{{ table }}_base'{% raw %}) }}{% endraw %}
