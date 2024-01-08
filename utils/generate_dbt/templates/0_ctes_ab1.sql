{% raw %}
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', {% endraw %}'{{ table }}'{% raw %}) }}{% endraw %}

select
  {% if all_columns %}{{ all_columns | indent(1, True) }},{% endif %}
   {% raw %}{{ dbt_utils.surrogate_key([{% endraw %}
   {% if columns_for_hashid %}{{ columns_for_hashid | indent(2, True) }}{% endif %}
    {% raw %}]) }}{% endraw %} as _airbyte_{{ table }}_hashid
from {% raw %}{{ source('cta', {% endraw %}'{{ table }}'{% raw %}) }}{% endraw %}