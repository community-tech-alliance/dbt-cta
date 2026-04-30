-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_people_lookup') }}

select
    of_person_id,
    state_file_id,
    dwid,
    voterbase_id,
    dnc_person_id,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_people_lookup') }}
