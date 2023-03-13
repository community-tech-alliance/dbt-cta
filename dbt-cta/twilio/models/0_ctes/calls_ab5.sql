{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to create final CTE using only the earliest emitted rows for each hashid
-- Why? In case something _weird_ happens with the incremental logic and Airbyte syncs the same row more than once
-- This guarantees that if a hashid is emitted a second time, it wont be added to the CTA base table

-- depends_on: {{ ref('calls_ab4') }}
select
    ab3.*
from {{ ref('calls_ab3') }} as ab3
join {{ ref('calls_ab4') }} as ab4 
    on ab3._airbyte_calls_hashid = ab4._airbyte_calls_hashid
    and ab3._airbyte_emitted_at = ab4._airbyte_emitted_at
-- calls
where 1 = 1
