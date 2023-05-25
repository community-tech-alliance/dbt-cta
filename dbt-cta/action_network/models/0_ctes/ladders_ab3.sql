{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ladders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'notes',
        'stats',
        'title',
        'hidden',
        'status',
        'group_id',
        'structure',
        'created_at',
        'creator_id',
        'updated_at',
        'auto_end_date',
        'schedule_action',
    ]) }} as _airbyte_ladders_hashid,
    tmp.*
from {{ ref('ladders_ab2') }} tmp
-- ladders
where 1 = 1

