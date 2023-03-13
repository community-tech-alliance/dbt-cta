{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to create final CTE using only the earliest emitted rows for each hashid
-- Why? In case something _weird_ happens with the incremental logic and Airbyte syncs the same row more than once
-- This guarantees that if a hashid is emitted a second time, it wont be added to the CTA base table

-- depends_on: {{ ref('usage_records_ab4') }}
select
    ab3.*
from {{ ref('usage_records_ab3') }} as ab3
join {{ ref('usage_records_ab4') }} as ab4 
    on ab3._airbyte_usage_records_hashid = ab4._airbyte_usage_records_hashid
    and ab3._airbyte_emitted_at = ab4._airbyte_emitted_at
-- usage_records
where 1 = 1
