-- depends_on: {{ source('cta', 'van_signups_base') }}
select
    _airbyte_van_signups_hashid,
    max(id) as id,
    max(van_id) as van_id,
    max(user_id) as user_id,
    max(signup_type) as signup_type,
    max(timeslot_id) as timeslot_id,
    max(committee_id) as committee_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(participation_id) as participation_id,
    max(van_event_van_id) as van_event_van_id,
    max(van_shift_van_id) as van_shift_van_id,
    max(van_person_van_id) as van_person_van_id,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "van_signups_base") }}
group by _airbyte_van_signups_hashid
