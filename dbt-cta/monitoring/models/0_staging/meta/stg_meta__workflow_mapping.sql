with source as (
    select * from {{ source('meta', 'workflow_mapping') }}
)

select workflow_id
, sync
, partner_name
, data_type
from source