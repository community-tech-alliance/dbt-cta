{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'meetings') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    notes,
    end_time,
    created_at,
    type,
    location_id,
    additional_person_id,
    start_time,
    updated_at,
    user_id,
    guest_attended,
    cancelled,
    id,
    person_id,
   {{ dbt_utils.surrogate_key([
     'notes',
    'type',
    'location_id',
    'additional_person_id',
    'user_id',
    'guest_attended',
    'cancelled',
    'id',
    'person_id'
    ]) }} as _airbyte_meetings_hashid
from {{ source('cta', 'meetings') }}
