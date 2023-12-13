{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_four_weekly_active_users_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('four_weekly_active_users_ab1') }}
select * except (_airbyte_raw_id)
from {{ ref('four_weekly_active_users_ab1') }}
