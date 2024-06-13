{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ads_stats_daily_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'end_time',
        'start_time',
    ]) }} as _airbyte_ads_stats_daily_hashid,
    tmp.*
from {{ ref('ads_stats_daily_ab2') }} as tmp
where 1 = 1
