-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', '_stg_turf') }}

select
    id,
    count_of_targets,
    status,
    status_time,
    checkout_time,
    completion_time,
    time_last_active,
    geom,
    cluster,
    canvasser_id,
    censusblock_id,
    label_id,
    current_timestamp() as _cta_loaded_at
from {{ source('cta', '_stg_turf') }}
