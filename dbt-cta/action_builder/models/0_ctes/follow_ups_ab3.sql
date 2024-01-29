{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('follow_ups_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'entity_id',
        'created_at',
        'updated_at',
        'campaign_id',
        'completed_at',
        'created_by_id',
        'completed_by_id',
        'assigned_user_id',
    ]) }} as _airbyte_follow_ups_hashid,
    tmp.*
from {{ ref('follow_ups_ab2') }} as tmp
-- follow_ups
where 1 = 1
