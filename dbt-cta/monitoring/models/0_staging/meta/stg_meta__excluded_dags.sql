with source as (
    select * from {{ source('meta', 'excluded_dags') }}
)

select dag_id
from source