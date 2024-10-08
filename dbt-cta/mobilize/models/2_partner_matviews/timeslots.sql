-- depends_on: {{ source('cta', 'timeslots_base') }}
select
    _airbyte_timeslots_hashid,
    max(id) as id,
    max(end_date) as end_date,
    max(event_id) as event_id,
    max(start_date) as start_date,
    max(created_date) as created_date,
    max(deleted_date) as deleted_date,
    max(max_attendees) as max_attendees,
    max(modified_date) as modified_date,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "timeslots_base") }}
group by _airbyte_timeslots_hashid
