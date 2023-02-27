{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('conference_participants_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'uri',
        boolean_to_string('hold'),
        'label',
        boolean_to_string('muted'),
        'status',
        'call_sid',
        boolean_to_string('coaching'),
        'account_sid',
        'date_created',
        'date_updated',
        'conference_sid',
        'call_sid_to_coach',
        boolean_to_string('end_conference_on_exit'),
        boolean_to_string('start_conference_on_enter'),
    ]) }} as _airbyte_conference_participants_hashid,
    tmp.*
from {{ ref('conference_participants_ab2') }} tmp
-- conference_participants
where 1 = 1

