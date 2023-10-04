{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activity_events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'item_id',
        'payload',
        'user_id',
        'datetime',
        'item_type',
        'target_id',
        'created_at',
        'event_type',
        'updated_at',
        'campaign_id',
        'target_type',
    ]) }} as _airbyte_activity_events_hashid,
    tmp.*
from {{ ref('activity_events_ab2') }} as tmp
-- activity_events
where 1 = 1
