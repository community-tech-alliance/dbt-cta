{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}

-- Final base SQL model
-- depends_on: {{ ref('spam_spamchecklog_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('spam_spamchecklog_ab2') }}
{% if is_incremental() %}
where _airbyte_extracted_at >= (select max(_airbyte_extracted_at) from {{ this }})
{% endif %}
