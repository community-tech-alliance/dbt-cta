{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'event_attendees') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    role,
    needs,
    status,
    event_id,
    person_id,
    created_at,
    creator_id,
    inviter_id,
    updated_at,
    marked_no_show_at,
    marked_walk_in_at,
    marked_attended_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'role',
    'needs',
    'status',
    'event_id',
    'person_id',
    'creator_id',
    'inviter_id'
    ]) }} as _airbyte_event_attendees_hashid
from {{ source('cta', 'event_attendees') }}
