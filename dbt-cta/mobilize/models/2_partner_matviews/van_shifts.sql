-- depends_on: {{ source('cta', 'van_shifts_base') }}
select
    _airbyte_van_shifts_hashid,
    max(id) as id,
    max(van_id) as van_id,
    max(end_date) as end_date,
    max(start_date) as start_date,
    max(timeslot_id) as timeslot_id,
    max(committee_id) as committee_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(sync_aggregation) as sync_aggregation,
    max(van_event_van_id) as van_event_van_id,
    max(event_campaign_id) as event_campaign_id,
    max(van_event_campaign_timezone) as van_event_campaign_timezone,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "van_shifts_base") }}
group by _airbyte_van_shifts_hashid
