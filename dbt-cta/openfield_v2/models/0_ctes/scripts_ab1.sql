-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_raw_scripts') }}

select
    id,
    campaign_id,
    name,
    description,
    language,
    created_at,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _scripts_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_raw_scripts') }}
