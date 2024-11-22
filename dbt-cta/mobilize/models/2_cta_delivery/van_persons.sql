-- depends_on: {{ source('cta', 'van_persons_base') }}
select
    _airbyte_van_persons_hashid,
    max(id) as id,
    max(van_id) as van_id,
    max(user_id) as user_id,
    max(committee_id) as committee_id,
    max(created_date) as created_date,
    max(modified_date) as modified_date,
    max(_airbyte_raw_id) as _airbyte_raw_id,
    max(_airbyte_extracted_at) as _airbyte_extracted_at
from {{ source("cta", "van_persons_base") }}
group by _airbyte_van_persons_hashid
