{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ads_insights_comscore_market_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('ads_insights_comscore_market_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('ads_insights_comscore_market_ab2') }}
{% if is_incremental() %}
where _airbyte_extracted_at >= (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}
