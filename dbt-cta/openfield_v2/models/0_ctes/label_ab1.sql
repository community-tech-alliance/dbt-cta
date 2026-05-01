-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_raw_label') }}

select
    id,
    campaign_id,
    name,
    description,
    created_at,
    created_by_id,
    archived_at,
    is_archived,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _label_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_raw_label') }}
