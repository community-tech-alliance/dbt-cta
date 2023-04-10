{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        object_to_string('data'),
        'type',
        'object',
        'created',
        'request',
        boolean_to_string('livemode'),
        'api_version',
        'pending_webhooks',
    ]) }} as _airbyte_events_hashid,
    tmp.*
from {{ ref('events_ab2') }} tmp
-- events
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

