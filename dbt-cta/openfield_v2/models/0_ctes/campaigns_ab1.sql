-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_campaigns') }}

select
    id,
    name,
    created_at,
    created_by_id,
    {{ current_timestamp() }} as _cta_loaded_at
from {{ source('cta', '_stg_campaigns') }}
