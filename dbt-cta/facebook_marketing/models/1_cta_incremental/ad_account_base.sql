{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ad_account_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('ad_account_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('ad_account_ab2') }}
