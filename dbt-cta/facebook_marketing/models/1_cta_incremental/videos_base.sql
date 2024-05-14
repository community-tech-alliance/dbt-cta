{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_videos_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('videos_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('videos_ab2') }}