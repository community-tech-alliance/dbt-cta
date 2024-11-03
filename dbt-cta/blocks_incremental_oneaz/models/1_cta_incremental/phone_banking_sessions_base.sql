{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}

-- Final base SQL model
-- depends_on: {{ ref('phone_banking_sessions_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('phone_banking_sessions_ab2') }}