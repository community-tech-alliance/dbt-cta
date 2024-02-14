{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('twitter_profile_analytics_ab1') }}

select
    *,
    -- to do: add all unnested fields and all fields to surrogate_key
   {{ dbt_utils.surrogate_key([
      
    ]) }} as _airbyte_twitter_profile_analytics_hashid
from {{ ref('twitter_profile_analytics_ab1') }}
