{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_age_to_bin_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('age_to_bin_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('age_to_bin_ab2') }}