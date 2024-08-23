{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}

-- Final base SQL model
-- depends_on: {{ ref('customer_users_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('customer_users_ab2') }}
