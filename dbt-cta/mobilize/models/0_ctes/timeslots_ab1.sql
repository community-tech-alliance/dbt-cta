
-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source("cta", "_airbyte_raw_timeslots" ) }}
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['end_date']") as end_date,
    json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
    json_extract_scalar(_airbyte_data, "$['start_date']") as start_date,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['deleted_date']") as deleted_date,
    json_extract_scalar(_airbyte_data, "$['max_attendees']") as max_attendees,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ source("cta", "_airbyte_raw_timeslots") }} as table_alias
-- timeslots
where 1 = 1
