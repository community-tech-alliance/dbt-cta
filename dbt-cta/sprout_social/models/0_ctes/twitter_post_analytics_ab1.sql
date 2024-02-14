{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twitter_post_analytics') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    sent,
    text,
    metrics,
    -- TO DO: metrics fields unnested
    internal,
    perma_link,
    created_time,
    customer_profile_id,
   {{ dbt_utils.surrogate_key([
     'sent',
    'text',
    'perma_link',
    'created_time',
    'customer_profile_id'
    ]) }} as _airbyte_twitter_post_analytics_hashid
from {{ source('cta', 'twitter_post_analytics') }}
