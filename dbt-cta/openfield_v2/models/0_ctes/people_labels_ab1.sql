-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_people_labels') }}

select
    id,
    campaign_id,
    people_id,
    list_id,
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id'
    ]) }} as _people_labels_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_people_labels') }}
