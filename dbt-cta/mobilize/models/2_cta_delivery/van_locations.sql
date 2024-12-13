-- depends_on: {{ source('cta', 'van_events_base') }}
select
    _airbyte_van_events_hashid,
    max(id) as id,
    max(van_id) as van_id,
    max(event_id) as event_id,
    max(committee_id) as committee_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "van_events_base") }}
group by _airbyte_van_events_hashid
