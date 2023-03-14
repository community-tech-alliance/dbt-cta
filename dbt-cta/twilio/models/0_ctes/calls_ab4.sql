{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to create final CTE using only the most recent `date_updated` value

-- depends_on: {{ ref('calls_ab3') }}
select
    ab3.*
from {{ ref('calls_ab2') }} as ab2
join {{ ref('calls_ab3') }} as ab3 
    on ab2.sid = ab3.sid
    and ab2.date_updated = ab3.date_updated
-- calls
where 1 = 1
