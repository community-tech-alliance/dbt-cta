with source as (
    select * from {{ source('meta', 'dag_mapping') }}
)

select dag_id
, sync
, partner_name
, data_type
from source