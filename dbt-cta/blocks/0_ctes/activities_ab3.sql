{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('activities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'recipient_type',
        'trackable_id',
        'updated_at',
        'owner_id',
        'created_at',
        'id',
        'trackable_type',
        'parameters',
        'key',
        'owner_type',
        'recipient_id',
    ]) }} as _airbyte_activities_hashid,
    tmp.*
from {{ ref('activities_ab2') }} tmp
-- activities
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

