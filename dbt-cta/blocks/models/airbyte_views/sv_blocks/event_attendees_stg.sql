{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_attendees_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'needs',
        'marked_no_show_at',
        'marked_walk_in_at',
        'event_id',
        'updated_at',
        'inviter_id',
        'creator_id',
        'created_at',
        'id',
        'marked_attended_at',
        'status',
        'person_id',
    ]) }} as _airbyte_event_attendees_hashid,
    tmp.*
from {{ ref('event_attendees_ab2') }} tmp
-- event_attendees
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

