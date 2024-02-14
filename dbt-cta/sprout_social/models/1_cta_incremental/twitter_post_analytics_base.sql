{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_twitter_post_analytics_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('twitter_post_analytics_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('twitter_post_analytics_ab2') }}
