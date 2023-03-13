{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to get latest updated dates for each hashid
-- depends_on: {{ ref('usage_records_ab3') }}
select
    _airbyte_usage_records_hashid,
    min(_airbyte_emitted_at) as _airbyte_emitted_at
from {{ ref('usage_records_ab3') }} tmp
-- usage_records
where 1 = 1
group by _airbyte_usage_records_hashid

