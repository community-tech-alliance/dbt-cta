{% raw %}{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_{% endraw %}{{ table }}{% raw %}_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('{% endraw %}{{ table }}{% raw %}_ab2') }}{% endraw %}
select * except (_airbyte_raw_id)
from {% raw %}{{ ref('{% endraw %}{{ table }}{% raw %}_ab2') }}
{% if is_incremental() %}
where _airbyte_extracted_at >= (select max(_airbyte_extracted_at) from {{ this }} )
{% endif %}
{% endraw %}
