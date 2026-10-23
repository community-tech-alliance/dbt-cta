-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_raw_laborids') }}

select
    state,
    dwid,
    voter_file_vanid,
    afl_cope_id,
    {{ dbt_utils.surrogate_key([
        'dwid',
        'voter_file_vanid',
        'afl_cope_id'
    ]) }} as _laborids_hashid,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_raw_laborids') }}
