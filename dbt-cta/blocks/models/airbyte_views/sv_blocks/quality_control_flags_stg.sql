{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quality_control_flags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'notes',
        'canvasser_id',
        'trigger_id',
        'reviewed_at',
        'created_at',
        'completed_at',
        'ready_at',
        'updated_at',
        'packet_id',
        'action_plan',
        'triggered_by_shift_id',
        'id',
        'status',
    ]) }} as _airbyte_quality_control_flags_hashid,
    tmp.*
from {{ ref('quality_control_flags_ab2') }} tmp
-- quality_control_flags
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

