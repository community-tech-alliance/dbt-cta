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
    id,
    type,
    notes,
    user_id,
    end_time,
    cancelled,
    person_id,
    created_at,
    start_time,
    updated_at,
    campaign_id,
    location_id,
    guest_attended,
    additional_person_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'type',
    'notes',
    'user_id',
    'cancelled',
    'person_id',
    'location_id',
    'guest_attended',
    'additional_person_id'
    ]) }} as _airbyte_meetings_hashid
from {{ source('cta', 'meetings') }}
