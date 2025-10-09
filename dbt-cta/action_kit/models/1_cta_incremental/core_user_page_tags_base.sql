{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_core_user_page_tags_hashid",
    tags=["cta","cdc"]
) }}

-- Final base SQL model
-- depends_on: {{ ref('core_user_page_tags_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('core_user_page_tags_ab2') }}
{% if is_incremental() %}
where _airbyte_extracted_at >= (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}
