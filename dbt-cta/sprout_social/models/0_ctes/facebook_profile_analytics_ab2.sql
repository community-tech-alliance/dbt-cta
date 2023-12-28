{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('facebook_profile_analytics_ab1') }}

select
    *,
   {{ dbt_utils.surrogate_key([
    'customer_profile_id',
    'reporting_period_day',
    ]) }} as _airbyte_facebook_profile_analytics_hashid
from {{ ref('facebook_profile_analytics_ab1') }}
