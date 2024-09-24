-- depends_on: {{ source('cta', 'event_tags_base') }}
select
    _airbyte_event_tags_hashid,
    max(id) as id,
    max(tag_id) as tag_id,
    max(event_id) as event_id,
    max(tag__name) as tag__name,
    max(created_date) as created_date,
    max(deleted_date) as deleted_date,
    max(modified_date) as modified_date,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "event_tags_base") }}
group by _airbyte_event_tags_hashid
