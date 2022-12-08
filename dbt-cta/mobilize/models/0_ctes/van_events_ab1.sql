
-- SQL model to parse JSON blob stored in a single column and extract into separated
-- field columns as described by the JSON Schema
-- depends_on: {{ source("cta", "_airbyte_raw_van_events" ) }}
select
    json_extract_scalar(_airbyte_data, "$['id']") as id,
    json_extract_scalar(_airbyte_data, "$['van_id']") as van_id,
    json_extract_scalar(_airbyte_data, "$['event_id']") as event_id,
    json_extract_scalar(_airbyte_data, "$['committee_id']") as committee_id,
    json_extract_scalar(_airbyte_data, "$['created_date']") as created_date,
    json_extract_scalar(_airbyte_data, "$['modified_date']") as modified_date,
    json_extract_scalar(_airbyte_data, "$['sync_aggregation']") as sync_aggregation,
    json_extract_scalar(_airbyte_data, "$['event_campaign_id']") as event_campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    current_timestamp() as _airbyte_normalized_at
from {{ source("cta", "_airbyte_raw_van_events") }} as table_alias
-- van_events
where 1 = 1
