{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('triggers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'uuid',
        'title',
        'step_id',
        'group_id',
        'ladder_id',
        'permalink',
        'created_at',
        'updated_at',
        'webhook_id',
        'action_type',
        'trigger_type',
        'exclude_uploads',
        'only_text_to_join',
    ]) }} as _airbyte_triggers_hashid,
    tmp.*
from {{ ref('triggers_ab2') }} as tmp
-- triggers
where 1 = 1
