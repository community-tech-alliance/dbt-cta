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
    needs,
    marked_no_show_at,
    marked_walk_in_at,
    event_id,
    updated_at,
    inviter_id,
    creator_id,
    created_at,
    id,
    marked_attended_at,
    status,
    person_id,
   {{ dbt_utils.surrogate_key([
     'needs',
    'event_id',
    'inviter_id',
    'creator_id',
    'id',
    'status',
    'person_id'
    ]) }} as _airbyte_event_attendees_hashid
from {{ source('cta', 'event_attendees') }}
